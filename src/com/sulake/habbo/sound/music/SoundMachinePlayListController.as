package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import flash.events.Event;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;
    import com.sulake.habbo.sound.*;

    public class SoundMachinePlayListController implements IPlayListController 
    {

        private var _soundManager:HabboSoundManagerFlash10;
        private var _SafeStr_3735:HabboMusicController;
        private var _connection:IConnection;
        private var _SafeStr_913:IEventDispatcher;
        private var _roomEvents:IEventDispatcher;
        private var _nowPlayingSongId:int = -1;
        private var _SafeStr_3737:Array = [];
        private var _isPlaying:Boolean;
        private var _disposed:Boolean = false;
        private var _messageEvents:Array;

        public function SoundMachinePlayListController(_arg_1:HabboSoundManagerFlash10, _arg_2:HabboMusicController, _arg_3:IEventDispatcher, _arg_4:IEventDispatcher, _arg_5:IConnection)
        {
            _soundManager = _arg_1;
            _SafeStr_913 = _arg_3;
            _roomEvents = _arg_4;
            _connection = _arg_5;
            _SafeStr_3735 = _arg_2;
            _messageEvents = [];
            _messageEvents.push(new PlayListMessageEvent(onPlayListMessage));
            _messageEvents.push(new PlayListSongAddedMessageEvent(onPlayListSongAddedMessage));
            for each (var _local_6:IMessageEvent in _messageEvents)
            {
                _connection.addMessageEvent(_local_6);
            };
            _SafeStr_913.addEventListener("SCE_TRAX_SONG_COMPLETE", onSongFinishedPlayingEvent);
            _SafeStr_913.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
            _roomEvents.addEventListener("ROSM_SOUND_MACHINE_SWITCHED_ON", onSoundMachinePlayEvent);
            _roomEvents.addEventListener("ROSM_SOUND_MACHINE_SWITCHED_OFF", onSoundMachineStopEvent);
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get priority():int
        {
            return (0);
        }

        public function get length():int
        {
            if (_SafeStr_3737 == null)
            {
                return (0);
            };
            return (_SafeStr_3737.length);
        }

        public function get playPosition():int
        {
            return (-1);
        }

        public function get nowPlayingSongId():int
        {
            return (_nowPlayingSongId);
        }

        public function get isPlaying():Boolean
        {
            return (_isPlaying);
        }

        public function set playPosition(_arg_1:int):void
        {
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_isPlaying)
                {
                    stopPlaying();
                };
                _soundManager = null;
                if (_connection)
                {
                    for each (var _local_1:IMessageEvent in _messageEvents)
                    {
                        _connection.removeMessageEvent(_local_1);
                        _local_1.dispose();
                    };
                    _messageEvents = null;
                    _connection = null;
                };
                _SafeStr_3737 = null;
                _SafeStr_3735 = null;
                if (_SafeStr_913)
                {
                    _SafeStr_913.removeEventListener("SCE_TRAX_SONG_COMPLETE", onSongFinishedPlayingEvent);
                    _SafeStr_913 = null;
                };
                if (_roomEvents)
                {
                    _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_SWITCHED_ON", onSoundMachinePlayEvent);
                    _roomEvents.removeEventListener("ROSM_SOUND_MACHINE_SWITCHED_OFF", onSoundMachineStopEvent);
                    _roomEvents = null;
                };
                _disposed = true;
            };
        }

        private function onSoundMachinePlayEvent(_arg_1:Event):void
        {
            startPlaying();
        }

        private function onSoundMachineStopEvent(_arg_1:Event):void
        {
            stopPlaying();
        }

        public function startPlaying():void
        {
            if (_isPlaying)
            {
                return;
            };
            if (((_SafeStr_3737 == null) || (_SafeStr_3737.length == 0)))
            {
                requestPlayList();
                _isPlaying = true;
                return;
            };
            stopPlaying();
            _nowPlayingSongId = -1;
            _isPlaying = true;
            playNextSong();
        }

        public function checkSongPlayState(_arg_1:int):void
        {
            var _local_2:SongDataEntry;
            if (_nowPlayingSongId == _arg_1)
            {
                playCurrentSongAndNotify(_nowPlayingSongId);
                _local_2 = getNextEntry();
                if (_local_2 != null)
                {
                    _SafeStr_3735.addSongInfoRequest(_local_2.id);
                };
            };
        }

        public function stopPlaying():void
        {
            _nowPlayingSongId = -1;
            _isPlaying = false;
            _SafeStr_3735.stop(0);
        }

        public function updateVolume(_arg_1:Number):void
        {
        }

        public function addItem(_arg_1:ISongInfo, _arg_2:int=0):int
        {
            return (-1);
        }

        public function moveItem(_arg_1:int, _arg_2:int):void
        {
        }

        public function removeItem(_arg_1:int):void
        {
        }

        private function onSongFinishedPlayingEvent(_arg_1:SoundCompleteEvent):void
        {
            if (_arg_1.id == _nowPlayingSongId)
            {
                playNextSong();
            };
        }

        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:SongDataEntry;
            var _local_4:int;
            var _local_3:SongDataEntry;
            if (((_SafeStr_3737 == null) || (_SafeStr_3737.length == 0)))
            {
                return;
            };
            _local_4 = 0;
            while (_local_4 < _SafeStr_3737.length)
            {
                _local_2 = _SafeStr_3737[_local_4];
                if (_local_2.id == _arg_1.id)
                {
                    _local_3 = (_SafeStr_3735.getSongInfo(_arg_1.id) as SongDataEntry);
                    if (_local_3 != null)
                    {
                        _SafeStr_3737[_local_4] = _local_3;
                    };
                    return;
                };
                _local_4++;
            };
        }

        private function playNextSong():void
        {
            var _local_1:SongDataEntry = getNextEntry();
            if (_local_1 != null)
            {
                _nowPlayingSongId = _local_1.id;
                playCurrentSongAndNotify(_nowPlayingSongId);
            };
        }

        private function playCurrentSongAndNotify(_arg_1:int):void
        {
            var _local_2:SongDataEntry = (getEntryWithId(_arg_1) as SongDataEntry);
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:Number = _local_2.startPlayHeadPos;
            _local_2.startPlayHeadPos = 0;
            if (_SafeStr_3735.playSong(_arg_1, 0, _local_3, 0, 0, 0))
            {
                Logger.log(((("Trax song started by playlist: " + _local_2.name) + " by ") + _local_2.creator));
            };
        }

        private function getNextEntry():SongDataEntry
        {
            var _local_1:SongDataEntry;
            var _local_2:int;
            if (((_SafeStr_3737 == null) || (_SafeStr_3737.length == 0)))
            {
                return (null);
            };
            var _local_3:int;
            _local_2 = 0;
            while (_local_2 < _SafeStr_3737.length)
            {
                _local_1 = _SafeStr_3737[_local_2];
                if (_local_1.id == _nowPlayingSongId)
                {
                    _local_3 = (_local_2 + 1);
                };
                _local_2++;
            };
            if (_local_3 >= _SafeStr_3737.length)
            {
                _local_3 = 0;
            };
            return (_SafeStr_3737[_local_3]);
        }

        public function getEntry(_arg_1:int):ISongInfo
        {
            if ((((_SafeStr_3737 == null) || (_arg_1 < 0)) || (_arg_1 >= _SafeStr_3737.length)))
            {
                return (null);
            };
            return (_SafeStr_3737[_arg_1]);
        }

        public function getEntryWithId(_arg_1:int):ISongInfo
        {
            var _local_2:SongDataEntry;
            var _local_3:int;
            if (((_SafeStr_3737 == null) || (_SafeStr_3737.length == 0)))
            {
                return (null);
            };
            _local_3 = 0;
            while (_local_3 < _SafeStr_3737.length)
            {
                _local_2 = _SafeStr_3737[_local_3];
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
                _local_3++;
            };
            return (null);
        }

        public function requestPlayList():void
        {
            if (_connection == null)
            {
                return;
            };
            _connection.send(new GetSoundMachinePlayListMessageComposer());
        }

        private function convertParserPlayList(_arg_1:Array):Array
        {
            var _local_3:Array = [];
            for each (var _local_2:PlayListEntry in _arg_1)
            {
                _local_3.push(new SongDataEntry(_local_2.id, _local_2.length, _local_2.name, _local_2.creator, null));
            };
            return (_local_3);
        }

        private function onPlayListMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:SongDataEntry;
            var _local_7:int;
            var _local_5:PlayListMessageEvent = (_arg_1 as PlayListMessageEvent);
            var _local_4:PlayListMessageParser = (_local_5.getParser() as PlayListMessageParser);
            var _local_6:int = _local_4.synchronizationCount;
            var _local_3:Array = convertParserPlayList(_local_4.playList);
            if (((_local_3 == null) || (_local_3.length == 0)))
            {
                return;
            };
            _SafeStr_3737 = _local_3;
            var _local_8:int;
            _local_7 = 0;
            while (_local_7 < _local_3.length)
            {
                _local_2 = _SafeStr_3737[_local_7];
                _local_8 = (_local_8 + _local_2.length);
                _local_7++;
            };
            if (_local_6 < 0)
            {
                _local_6 = 0;
            };
            _local_6 = (_local_6 % _local_8);
            _local_7 = 0;
            while (_local_7 < _local_3.length)
            {
                _local_2 = _SafeStr_3737[_local_7];
                if (_local_6 > _local_2.length)
                {
                    _local_6 = (_local_6 - _local_2.length);
                }
                else
                {
                    _nowPlayingSongId = _local_2.id;
                    _local_2.startPlayHeadPos = (_local_6 / 1000);
                    break;
                };
                _local_7++;
            };
            _SafeStr_913.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
            if (((!(_local_2 == null)) && (_isPlaying)))
            {
                playCurrentSongAndNotify(_local_2.id);
            };
        }

        private function onPlayListSongAddedMessage(_arg_1:IMessageEvent):void
        {
            var _local_4:PlayListSongAddedMessageEvent = (_arg_1 as PlayListSongAddedMessageEvent);
            var _local_3:PlayListSongAddedMessageParser = (_local_4.getParser() as PlayListSongAddedMessageParser);
            var _local_2:SongDataEntry = new SongDataEntry(_local_3.entry.id, _local_3.entry.length, _local_3.entry.name, _local_3.entry.creator, null);
            if (_local_2 == null)
            {
                return;
            };
            _SafeStr_3737.push(_local_2);
            _SafeStr_913.dispatchEvent(new PlayListStatusEvent("PLUE_PLAY_LIST_UPDATED"));
            if (!_isPlaying)
            {
                return;
            };
            if (_SafeStr_3737.length == 1)
            {
                playCurrentSongAndNotify(_local_2.id);
            }
            else
            {
                checkSongPlayState(_local_2.id);
            };
        }


    }
}

