package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IPlayListController;
    import flash.utils.Timer;
    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.IHabboSound;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
    import com.sulake.habbo.sound.trax.TraxSequencer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
    import com.sulake.habbo.sound.*;

    public class HabboMusicController implements IHabboMusicController, IDisposable 
    {

        public static const SKIP_POSITION_SET:int = -1;
        private static const MAXIMUM_NOTIFY_PRIORITY:int = 0;

        private var _soundManager:HabboSoundManagerFlash10;
        private var _connection:IConnection;
        private var _events:IEventDispatcher;
        private var _roomEvents:IEventDispatcher;
        private var _SafeStr_3726:Map = new Map();
        private var _SafeStr_3727:Map = new Map();
        private var _SafeStr_3728:Array = [];
        private var _SafeStr_3729:IPlayListController = null;
        private var _disposed:Boolean = false;
        private var _SafeStr_3724:Array = [];
        private var _SafeStr_3725:Array = [];
        private var _SafeStr_3730:int = -1;
        private var _SafeStr_3731:int = -1;
        private var _SafeStr_3732:int = -1;
        private var _SafeStr_3723:Timer;
        private var _SafeStr_2101:Map = new Map();
        private var _SafeStr_3733:Array = [];
        private var _messageEvents:Array = [];
        private var _SafeStr_3734:int = -1;
        private var _previousNotificationTime:int = -1;

        public function HabboMusicController(_arg_1:HabboSoundManagerFlash10, _arg_2:IEventDispatcher, _arg_3:IEventDispatcher, _arg_4:IConnection)
        {
            var _local_5:int;
            super();
            _soundManager = _arg_1;
            _events = _arg_2;
            _roomEvents = _arg_3;
            _connection = _arg_4;
            _messageEvents.push(new TraxSongInfoMessageEvent(onSongInfoMessage));
            _messageEvents.push(new UserSongDisksInventoryMessageEvent(onSongDiskInventoryMessage));
            for each (var _local_6:IMessageEvent in _messageEvents)
            {
                _connection.addMessageEvent(_local_6);
            };
            _roomEvents.addEventListener("ROSM_JUKEBOX_INIT", onJukeboxInit);
            _roomEvents.addEventListener("ROSM_JUKEBOX_DISPOSE", onJukeboxDispose);
            _roomEvents.addEventListener("ROSM_SOUND_MACHINE_INIT", onSoundMachineInit);
            _roomEvents.addEventListener("ROSM_SOUND_MACHINE_DISPOSE", onSoundMachineDispose);
            _SafeStr_3723 = new Timer(1000);
            _SafeStr_3723.start();
            _SafeStr_3723.addEventListener("timer", sendNextSongRequestMessage);
            _events.addEventListener("SCE_TRAX_SONG_COMPLETE", onSongFinishedPlayingEvent);
            _local_5 = 0;
            while (_local_5 < 4)
            {
                _SafeStr_3724[_local_5] = null;
                _SafeStr_3725[_local_5] = 0;
                _local_5++;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get events():IEventDispatcher
        {
            return (_events);
        }

        protected function onSongFinishedPlayingEvent(_arg_1:SoundCompleteEvent):void
        {
            var _local_2:int;
            Logger.log((("Song " + _arg_1.id) + " finished playing"));
            if (getSongIdPlayingAtPriority(_SafeStr_3730) == _arg_1.id)
            {
                if (((getTopRequestPriority() == _SafeStr_3730) && (getSongRequestCountAtPriority(_SafeStr_3730) == _SafeStr_3732)))
                {
                    resetSongStartRequest(_SafeStr_3730);
                };
                _local_2 = _SafeStr_3730;
                playSongWithHighestPriority();
                if (_local_2 >= 2)
                {
                    _events.dispatchEvent(new NowPlayingEvent("NPW_USER_STOP_SONG", _local_2, _arg_1.id, -1));
                };
            };
        }

        public function dispose():void
        {
            var _local_3:int;
            var _local_1:SongDataEntry;
            var _local_2:IHabboSound;
            if (!_disposed)
            {
                _soundManager = null;
                _SafeStr_3728 = null;
                if (_connection)
                {
                    for each (var _local_4:IMessageEvent in _messageEvents)
                    {
                        _connection.removeMessageEvent(_local_4);
                        _local_4.dispose();
                    };
                    _messageEvents = null;
                    _connection = null;
                };
                if (_SafeStr_3729)
                {
                    _SafeStr_3729.dispose();
                    _SafeStr_3729 = null;
                };
                if (_SafeStr_3726)
                {
                    _local_3 = 0;
                    while (_local_3 < _SafeStr_3726.length)
                    {
                        _local_1 = (_SafeStr_3726.getWithIndex(_local_3) as SongDataEntry);
                        _local_2 = (_local_1.soundObject as IHabboSound);
                        if (_local_2 != null)
                        {
                            _local_2.stop();
                        };
                        _local_1.soundObject = null;
                        _local_3++;
                    };
                    _SafeStr_3726.dispose();
                    _SafeStr_3726 = null;
                };
                if (_SafeStr_3727 != null)
                {
                    _SafeStr_3727.dispose();
                    _SafeStr_3727 = null;
                };
                _SafeStr_3723.stop();
                _SafeStr_3723 = null;
                if (_roomEvents)
                {
                    _roomEvents.removeEventListener("ROSM_JUKEBOX_INIT", onJukeboxInit);
                    _roomEvents.removeEventListener("ROSM_JUKEBOX_DISPOSE", onJukeboxDispose);
                    _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_INIT", onSoundMachineInit);
                    _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_DISPOSE", onSoundMachineDispose);
                };
                if (_SafeStr_2101 != null)
                {
                    _SafeStr_2101.dispose();
                    _SafeStr_2101 = null;
                };
                _disposed = true;
            };
        }

        public function getRoomItemPlaylist(_arg_1:int=-1):IPlayListController
        {
            return (_SafeStr_3729);
        }

        private function addSongStartRequest(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Boolean
        {
            if (((_arg_1 < 0) || (_arg_1 >= 4)))
            {
                return (false);
            };
            var _local_7:SongStartRequestData = new SongStartRequestData(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            _SafeStr_3724[_arg_1] = _local_7;
            var _local_8:int = _arg_1;
            var _local_9:int = (_SafeStr_3725[_local_8] + 1);
            _SafeStr_3725[_local_8] = _local_9;
            return (true);
        }

        private function getSongStartRequest(_arg_1:int):SongStartRequestData
        {
            return (_SafeStr_3724[_arg_1]);
        }

        private function getSongIdRequestedAtPriority(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= 4)))
            {
                return (-1);
            };
            if (_SafeStr_3724[_arg_1] == null)
            {
                return (-1);
            };
            var _local_2:SongStartRequestData = _SafeStr_3724[_arg_1];
            return (_local_2.songId);
        }

        private function getSongRequestCountAtPriority(_arg_1:int):int
        {
            if (((_arg_1 < 0) || (_arg_1 >= 4)))
            {
                return (-1);
            };
            return (_SafeStr_3725[_arg_1]);
        }

        private function getTopRequestPriority():int
        {
            var _local_1:int;
            _local_1 = (_SafeStr_3724.length - 1);
            while (_local_1 >= 0)
            {
                if (_SafeStr_3724[_local_1] != null)
                {
                    return (_local_1);
                };
                _local_1--;
            };
            return (-1);
        }

        private function resetSongStartRequest(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < 4)))
            {
                _SafeStr_3724[_arg_1] = null;
            };
        }

        private function reRequestSongAtPriority(_arg_1:int):void
        {
            var _local_2:int = _arg_1;
            var _local_3:Number = (_SafeStr_3725[_local_2] + 1);
            _SafeStr_3725[_local_2] = _local_3;
        }

        private function processSongEntryForPlaying(_arg_1:int, _arg_2:Boolean=true):Boolean
        {
            var _local_4:SongDataEntry = getSongDataEntry(_arg_1);
            if (_local_4 == null)
            {
                addSongInfoRequest(_arg_1);
                return (false);
            };
            if (_local_4.soundObject == null)
            {
                _local_4.soundObject = _soundManager.loadTraxSong(_local_4.id, _local_4.songData);
            };
            var _local_3:IHabboSound = _local_4.soundObject;
            if (!_local_3.ready)
            {
                return (false);
            };
            return (true);
        }

        public function playSong(_arg_1:int, _arg_2:int, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0.5, _arg_6:Number=0.5):Boolean
        {
            Logger.log((("Requesting " + _arg_1) + " for playing"));
            if (!addSongStartRequest(_arg_2, _arg_1, _arg_3, _arg_4, _arg_5, _arg_6))
            {
                return (false);
            };
            if (!processSongEntryForPlaying(_arg_1))
            {
                return (false);
            };
            if (_arg_2 >= _SafeStr_3730)
            {
                playSongObject(_arg_2, _arg_1);
            }
            else
            {
                Logger.log(((("Higher priority song blocked playing. Stored song " + _arg_1) + " for priority ") + _arg_2));
            };
            return (true);
        }

        private function playSongWithHighestPriority():void
        {
            var _local_2:int;
            var _local_3:int;
            _SafeStr_3730 = -1;
            _SafeStr_3731 = -1;
            _SafeStr_3732 = -1;
            var _local_1:int = getTopRequestPriority();
            _local_2 = _local_1;
            while (_local_2 >= 0)
            {
                _local_3 = getSongIdRequestedAtPriority(_local_2);
                if (((_local_3 >= 0) && (playSongObject(_local_2, _local_3))))
                {
                    return;
                };
                _local_2--;
            };
        }

        public function stop(_arg_1:int):void
        {
            var _local_2:Boolean = (_arg_1 == _SafeStr_3730);
            var _local_3:Boolean = (getTopRequestPriority() == _arg_1);
            if (_local_2)
            {
                resetSongStartRequest(_arg_1);
                stopSongAtPriority(_arg_1);
            }
            else
            {
                resetSongStartRequest(_arg_1);
                if (_local_3)
                {
                    reRequestSongAtPriority(_SafeStr_3730);
                };
            };
        }

        private function stopSongAtPriority(_arg_1:int):Boolean
        {
            var _local_3:int;
            var _local_2:SongDataEntry;
            if (((_arg_1 == _SafeStr_3730) && (_SafeStr_3730 >= 0)))
            {
                _local_3 = getSongIdPlayingAtPriority(_arg_1);
                if (_local_3 >= 0)
                {
                    _local_2 = getSongDataEntry(_local_3);
                    stopSongDataEntry(_local_2);
                    return (true);
                };
            };
            return (false);
        }

        private function stopSongDataEntry(_arg_1:SongDataEntry):void
        {
            var _local_2:IHabboSound;
            if (_arg_1 != null)
            {
                Logger.log(("Stopping current song " + _arg_1.id));
                _local_2 = _arg_1.soundObject;
                if (_local_2 != null)
                {
                    _local_2.stop();
                };
            };
        }

        private function getSongDataEntry(_arg_1:int):SongDataEntry
        {
            var _local_2:SongDataEntry;
            if (_SafeStr_3726 != null)
            {
                _local_2 = (_SafeStr_3726.getValue(_arg_1) as SongDataEntry);
            };
            return (_local_2);
        }

        public function updateVolume(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_2:SongDataEntry;
            _local_3 = 0;
            while (_local_3 < 4)
            {
                _local_4 = getSongIdPlayingAtPriority(_local_3);
                if (_local_4 >= 0)
                {
                    _local_2 = (getSongDataEntry(_local_4) as SongDataEntry);
                    if (((!(_local_2 == null)) && (!(_local_2.soundObject == null))))
                    {
                        _local_2.soundObject.volume = _arg_1;
                    };
                };
                _local_3++;
            };
        }

        public function onSongLoaded(_arg_1:int):void
        {
            var _local_3:int;
            Logger.log(("Song loaded : " + _arg_1));
            var _local_2:int = getTopRequestPriority();
            if (_local_2 >= 0)
            {
                _local_3 = getSongIdRequestedAtPriority(_local_2);
                if (_arg_1 == _local_3)
                {
                    playSongObject(_local_2, _arg_1);
                };
            };
        }

        public function addSongInfoRequest(_arg_1:int):void
        {
            requestSong(_arg_1, true);
        }

        public function requestSongInfoWithoutSamples(_arg_1:int):void
        {
            requestSong(_arg_1, false);
        }

        private function requestSong(_arg_1:int, _arg_2:Boolean):void
        {
            if (_SafeStr_3727.getValue(_arg_1) == null)
            {
                _SafeStr_3727.add(_arg_1, _arg_2);
                _SafeStr_3728.push(_arg_1);
            };
        }

        public function getSongInfo(_arg_1:int):ISongInfo
        {
            var _local_2:SongDataEntry = getSongDataEntry(_arg_1);
            if (_local_2 == null)
            {
                requestSongInfoWithoutSamples(_arg_1);
            };
            return (_local_2);
        }

        public function requestUserSongDisks():void
        {
            if (_connection == null)
            {
                return;
            };
            _connection.send(new GetUserSongDisksMessageComposer());
        }

        public function getSongDiskInventorySize():int
        {
            return (_SafeStr_2101.length);
        }

        public function getSongDiskInventoryDiskId(_arg_1:int):int
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_2101.length)))
            {
                return (_SafeStr_2101.getKey(_arg_1));
            };
            return (-1);
        }

        public function getSongDiskInventorySongId(_arg_1:int):int
        {
            if (((_arg_1 >= 0) && (_arg_1 < _SafeStr_2101.length)))
            {
                return (_SafeStr_2101.getWithIndex(_arg_1));
            };
            return (-1);
        }

        public function getSongIdPlayingAtPriority(_arg_1:int):int
        {
            if (_arg_1 != _SafeStr_3730)
            {
                return (-1);
            };
            return (_SafeStr_3731);
        }

        public function samplesUnloaded(_arg_1:Array):void
        {
            var _local_5:int;
            var _local_3:SongDataEntry;
            var _local_4:TraxSequencer;
            var _local_2:Array;
            var _local_6:int;
            _local_5 = 0;
            while (_local_5 < _SafeStr_3726.length)
            {
                _local_3 = (_SafeStr_3726.getWithIndex(_local_5) as SongDataEntry);
                _local_4 = (_local_3.soundObject as TraxSequencer);
                if ((((!(_local_3.id == _SafeStr_3731)) && (!(_local_4 == null))) && (_local_4.ready)))
                {
                    _local_2 = _local_4.traxData.getSampleIds();
                    _local_6 = 0;
                    while (_local_6 < _arg_1.length)
                    {
                        if (_local_2.indexOf(_arg_1[_local_6]) != -1)
                        {
                            _local_3.soundObject = null;
                            _local_4.dispose();
                            Logger.log(((("Unloaded " + _local_3.name) + " by ") + _local_3.creator));
                        };
                        _local_6++;
                    };
                };
                _local_5++;
            };
        }

        public function get samplesIdsInUse():Array
        {
            var _local_5:int;
            var _local_3:SongStartRequestData;
            var _local_2:SongDataEntry;
            var _local_1:TraxSequencer;
            var _local_4:Array = [];
            _local_5 = 0;
            while (_local_5 < _SafeStr_3724.length)
            {
                if (_SafeStr_3724[_local_5] != null)
                {
                    _local_3 = _SafeStr_3724[_local_5];
                    _local_2 = _SafeStr_3726.getValue(_local_3.songId);
                    if (_local_2 != null)
                    {
                        _local_1 = (_local_2.soundObject as TraxSequencer);
                        if (_local_1 != null)
                        {
                            _local_4 = _local_4.concat(_local_1.traxData.getSampleIds());
                        };
                    };
                };
                _local_5++;
            };
            return (_local_4);
        }

        private function sendNextSongRequestMessage(_arg_1:TimerEvent):void
        {
            if (_SafeStr_3728.length < 1)
            {
                return;
            };
            if (_connection == null)
            {
                return;
            };
            _connection.send(new GetSongInfoMessageComposer(_SafeStr_3728));
            Logger.log(("Requested song info's : " + _SafeStr_3728));
            _SafeStr_3728 = [];
        }

        private function onSongInfoMessage(_arg_1:IMessageEvent):void
        {
            var _local_8:int;
            var _local_9:SongInfoEntry;
            var _local_10:Boolean;
            var _local_4:Boolean;
            var _local_11:IHabboSound;
            var _local_12:SongDataEntry;
            var _local_5:int;
            var _local_6:int;
            var _local_3:TraxSongInfoMessageEvent = (_arg_1 as TraxSongInfoMessageEvent);
            var _local_2:TraxSongInfoMessageParser = (_local_3.getParser() as TraxSongInfoMessageParser);
            var _local_7:Array = _local_2.songs;
            _local_8 = 0;
            while (_local_8 < _local_7.length)
            {
                _local_9 = _local_7[_local_8];
                _local_10 = (getSongDataEntry(_local_9.id) == null);
                _local_4 = areSamplesRequested(_local_9.id);
                if (_local_10)
                {
                    _local_11 = null;
                    if (_local_4)
                    {
                        _local_11 = _soundManager.loadTraxSong(_local_9.id, _local_9.data);
                    };
                    _local_12 = new SongDataEntry(_local_9.id, _local_9.length, _local_9.name, _local_9.creator, _local_11);
                    _local_12.songData = _local_9.data;
                    _SafeStr_3726.add(_local_9.id, _local_12);
                    _local_5 = getTopRequestPriority();
                    _local_6 = getSongIdRequestedAtPriority(_local_5);
                    if ((((!(_local_11 == null)) && (_local_11.ready)) && (_local_9.id == _local_6)))
                    {
                        playSongObject(_local_5, _local_6);
                    };
                    _events.dispatchEvent(new SongInfoReceivedEvent("SIR_TRAX_SONG_INFO_RECEIVED", _local_9.id));
                    while (_SafeStr_3733.indexOf(_local_9.id) != -1)
                    {
                        _SafeStr_3733.splice(_SafeStr_3733.indexOf(_local_9.id), 1);
                        if (_SafeStr_3733.length == 0)
                        {
                            _events.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
                        };
                    };
                    Logger.log(("Received song info : " + _local_9.id));
                };
                _local_8++;
            };
        }

        private function playSongObject(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((_arg_2 == -1) || (_arg_1 < 0)) || (_arg_1 >= 4)))
            {
                return (false);
            };
            var _local_6:Boolean;
            if (stopSongAtPriority(_SafeStr_3730))
            {
                _local_6 = true;
            };
            var _local_5:SongDataEntry = getSongDataEntry(_arg_2);
            if (_local_5 == null)
            {
                Logger.log((("WARNING: Unable to find song entry id " + _arg_2) + " that was supposed to be loaded."));
                return (false);
            };
            var _local_3:IHabboSound = _local_5.soundObject;
            if (((_local_3 == null) || (!(_local_3.ready))))
            {
                return (false);
            };
            if (_local_6)
            {
                Logger.log(("Waiting previous song to stop before playing song " + _arg_2));
                return (true);
            };
            _local_3.volume = _soundManager.traxVolume;
            var _local_9:Number = -1;
            var _local_7:Number = 0;
            var _local_4:Number = 2;
            var _local_8:Number = 1;
            var _local_10:SongStartRequestData = getSongStartRequest(_arg_1);
            if (_local_10 != null)
            {
                _local_9 = _local_10.startPos;
                _local_7 = _local_10.playLength;
                _local_4 = _local_10.fadeInSeconds;
                _local_8 = _local_10.fadeOutSeconds;
            };
            if (_local_9 >= (_local_5.length / 1000))
            {
                return (false);
            };
            if (_local_9 == -1)
            {
                _local_9 = 0;
            };
            _local_3.fadeInSeconds = _local_4;
            _local_3.fadeOutSeconds = _local_8;
            _local_3.position = _local_9;
            _local_3.play(_local_7);
            _SafeStr_3730 = _arg_1;
            _SafeStr_3732 = getSongRequestCountAtPriority(_arg_1);
            _SafeStr_3731 = _arg_2;
            if (_SafeStr_3730 <= 0)
            {
                notifySongPlaying(_local_5);
            };
            if (_arg_1 > 0)
            {
                _events.dispatchEvent(new NowPlayingEvent("NPE_USER_PLAY_SONG", _arg_1, _local_5.id, -1));
            };
            Logger.log(((((((((("Started playing song " + _arg_2) + " at position ") + _local_9) + " for ") + _local_7) + " seconds (length ") + (_local_5.length / 1000)) + ") with priority ") + _arg_1));
            return (true);
        }

        private function notifySongPlaying(_arg_1:SongDataEntry):void
        {
            var _local_2:Number = 8000;
            var _local_3:int = getTimer();
            if (((_arg_1.length >= _local_2) && ((!(_SafeStr_3734 == _arg_1.id)) || (_local_3 > (_previousNotificationTime + _local_2)))))
            {
                _soundManager.notifyPlayedSong(_arg_1.name, _arg_1.creator);
                _SafeStr_3734 = _arg_1.id;
                _previousNotificationTime = _local_3;
            };
        }

        private function areSamplesRequested(_arg_1:int):Boolean
        {
            if (_SafeStr_3727.getValue(_arg_1) == null)
            {
                return (false);
            };
            return (_SafeStr_3727.getValue(_arg_1));
        }

        private function onSongDiskInventoryMessage(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_3:UserSongDisksInventoryMessageEvent = (_arg_1 as UserSongDisksInventoryMessageEvent);
            var _local_2:UserSongDisksInventoryMessageParser = (_local_3.getParser() as UserSongDisksInventoryMessageParser);
            _SafeStr_2101.reset();
            _local_4 = 0;
            while (_local_4 < _local_2.songDiskCount)
            {
                _local_5 = _local_2.getDiskId(_local_4);
                _local_6 = _local_2.getSongId(_local_4);
                _SafeStr_2101.add(_local_5, _local_6);
                if (_SafeStr_3726.getValue(_local_6) == null)
                {
                    _SafeStr_3733.push(_local_6);
                    requestSongInfoWithoutSamples(_local_6);
                };
                _local_4++;
            };
            if (_SafeStr_3733.length == 0)
            {
                _events.dispatchEvent(new SongDiskInventoryReceivedEvent("SDIR_SONG_DISK_INVENTORY_RECEIVENT_EVENT"));
            };
        }

        private function onSoundMachineInit(_arg_1:Event):void
        {
            disposeRoomPlaylist();
            _SafeStr_3729 = (new SoundMachinePlayListController(_soundManager, this, _events, _roomEvents, _connection) as IPlayListController);
        }

        private function onSoundMachineDispose(_arg_1:Event):void
        {
            disposeRoomPlaylist();
        }

        private function onJukeboxInit(_arg_1:Event):void
        {
            disposeRoomPlaylist();
            _SafeStr_3729 = (new JukeboxPlayListController(_soundManager, this, _events, _connection) as IPlayListController);
            _connection.send(new GetNowPlayingMessageComposer());
        }

        private function onJukeboxDispose(_arg_1:Event):void
        {
            disposeRoomPlaylist();
        }

        private function disposeRoomPlaylist():void
        {
            if (_SafeStr_3729 != null)
            {
                _SafeStr_3729.dispose();
                _SafeStr_3729 = null;
            };
        }


    }
}

