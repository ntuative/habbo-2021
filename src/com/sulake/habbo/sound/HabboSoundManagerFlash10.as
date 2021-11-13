package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.trax.TraxSequencer;
    import com.sulake.habbo.sound.music.TraxSampleManager;
    import com.sulake.habbo.sound.furni.FurniSamplePlaybackManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.media.Sound;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.sound.trax.TraxData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.sound.music.HabboMusicController;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
    import com.sulake.habbo.sound.events.TraxSongLoadEvent;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.preferences.SetSoundSettingsComposer;
    import com.sulake.habbo.communication.messages.parser.preferences.AccountPreferencesParser;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.room.events.RoomEngineObjectPlaySoundEvent;

    public class HabboSoundManagerFlash10 extends Component implements IHabboSoundManager, IUpdateReceiver 
    {

        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _roomEngine:IRoomEngine;
        private var _notifications:IHabboNotifications;
        private var _genericVolume:Number = 1;
        private var _traxVolume:Number = 1;
        private var _furniVolume:Number = 1;
        private var _SafeStr_613:Map = new Map();
        private var _loadingSongId:int = -1;
        private var _SafeStr_614:TraxSequencer;
        private var _musicController:IHabboMusicController;
        private var _SafeStr_612:TraxSampleManager;
        private var _onDemandSamplePlaybackManager:FurniSamplePlaybackManager;
        private var _SafeStr_615:Map = new Map();
        private var _SafeStr_616:Boolean = false;

        public function HabboSoundManagerFlash10(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null, _arg_4:Boolean=true)
        {
            super(_arg_1, _arg_2, _arg_3);
            if (_arg_4)
            {
                queueInterface(new IIDHabboCommunicationManager(), onCommunicationManagerReady);
                queueInterface(new IIDRoomEngine(), onRoomEngineReady);
                queueInterface(new IIDHabboNotifications(), onNotificationsReady);
            };
            events.addEventListener("TSLE_TRAX_LOAD_COMPLETE", onTraxLoadComplete);
            registerUpdateReceiver(this, 1);
            Logger.log("Sound manager 10 init");
        }

        public function get musicController():IHabboMusicController
        {
            return (_musicController);
        }

        public function get genericVolume():Number
        {
            return (_genericVolume);
        }

        public function set genericVolume(_arg_1:Number):void
        {
            updateVolumeSetting(_arg_1, _furniVolume, _traxVolume);
            storeVolumeSetting();
        }

        public function get traxVolume():Number
        {
            return (_traxVolume);
        }

        public function set traxVolume(_arg_1:Number):void
        {
            updateVolumeSetting(_genericVolume, _furniVolume, _arg_1);
            storeVolumeSetting();
        }

        public function get furniVolume():Number
        {
            return (_furniVolume);
        }

        public function set furniVolume(_arg_1:Number):void
        {
            updateVolumeSetting(_genericVolume, _arg_1, _traxVolume);
            storeVolumeSetting();
        }

        public function previewVolume(_arg_1:Number, _arg_2:Number, _arg_3:Number):void
        {
            updateVolumeSetting(_arg_1, _arg_2, _arg_3);
        }

        override public function dispose():void
        {
            _connection = null;
            if (_musicController)
            {
                _musicController.dispose();
                _musicController = null;
            };
            if (_SafeStr_612)
            {
                _SafeStr_612.dispose();
                _SafeStr_612 = null;
            };
            if (_SafeStr_613)
            {
                _SafeStr_613.dispose();
                _SafeStr_613 = null;
            };
            if (_onDemandSamplePlaybackManager)
            {
                _onDemandSamplePlaybackManager.dispose();
                _onDemandSamplePlaybackManager = null;
            };
            if (_communication)
            {
                _communication.release(new IIDHabboCommunicationManager());
                _communication = null;
            };
            if (_roomEngine)
            {
                _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND", onRoomEngineObjectPlaySound);
                _roomEngine.events.removeEventListener("REPSE_PLAY_SOUND_AT_PITCH", onRoomEngineObjectPlaySound);
                _roomEngine.release(new IIDRoomEngine());
                _roomEngine = null;
            };
            if (_notifications)
            {
                _notifications.release(new IIDHabboNotifications());
                _notifications = null;
            };
            super.dispose();
        }

        public function playSound(_arg_1:String, _arg_2:int=0):void
        {
            var _local_4:Sound;
            var _local_3:IHabboSound = _SafeStr_613.getValue(_arg_1);
            if (_local_3 == null)
            {
                _local_4 = getSoundBySoundId(_arg_1);
                if (_local_4 != null)
                {
                    _local_3 = new HabboSoundBase(_local_4, _arg_2);
                    _SafeStr_613.add(_arg_1, IHabboSound(_local_3));
                };
            };
            _local_3.volume = _genericVolume;
            _local_3.play();
        }

        public function playSoundAtPitch(_arg_1:String, _arg_2:Number):IHabboSound
        {
            var _local_4:Sound = getSoundBySoundId(_arg_1);
            if (_local_4 == null)
            {
                return (null);
            };
            var _local_3:HabboSoundWithPitch = new HabboSoundWithPitch(_local_4, _arg_2);
            _local_3.volume = _genericVolume;
            _local_3.play();
            return (_local_3);
        }

        public function stopSound(_arg_1:String):void
        {
            var _local_2:IHabboSound = _SafeStr_613.getValue(_arg_1);
            if (_local_2 != null)
            {
                _local_2.stop();
            };
        }

        public function get loadingSongId():int
        {
            return (_loadingSongId);
        }

        private function onSampleLoadError():void
        {
            _loadingSongId = -1;
            _SafeStr_614 = null;
        }

        private function getSoundBySoundId(_arg_1:String):Sound
        {
            var _local_2:String = "";
            switch (_arg_1)
            {
                case "HBST_call_for_help":
                    _local_2 = "sound_call_for_help";
                    break;
                case "HBST_guide_invitation":
                    _local_2 = "sound_guide_received_invitation";
                    break;
                case "HBST_guide_request":
                    _local_2 = "sound_guide_help_requested";
                    break;
                case "HBST_message_received":
                    _local_2 = "sound_console_new_message";
                    break;
                case "HBST_message_sent":
                    _local_2 = "sound_console_message_sent";
                    break;
                case "HBST_pixels":
                    _local_2 = "sound_catalogue_duckets";
                    break;
                case "HBST_purchase":
                    _local_2 = "sound_catalogue_cash";
                    break;
                case "HBST_respect":
                    _local_2 = "sound_respect_received";
                    break;
                case "CAMERA_shutter":
                    _local_2 = "sound_camera_shutter";
                    break;
                case "HBSTG_snowwar_get_snowball":
                case "HBSTG_snowwar_hit1":
                case "HBSTG_snowwar_hit2":
                case "HBSTG_snowwar_hit3":
                case "HBSTG_snowwar_make_snowball":
                case "HBSTG_snowwar_miss":
                case "HBSTG_snowwar_throw":
                case "HBSTG_snowwar_walk":
                case "HBSTG_ig_countdown":
                case "HBSTG_ig_winning":
                case "HBSTG_ig_losing":
                    _local_2 = _arg_1;
                    break;
                case "FURNITURE_cuckoo_clock":
                    _local_2 = _arg_1;
                    break;
                default:
                    Logger.log(("HabboSoundManagerFlash10: Unknown sound request: " + _arg_1));
                    return (null);
            };
            return (getSoundByAssetName(_local_2));
        }

        private function getSoundByAssetName(_arg_1:String):Sound
        {
            var _local_2:IAsset = assets.getAssetByName(_arg_1);
            return (_local_2.content as Sound);
        }

        public function loadTraxSong(_arg_1:int, _arg_2:String):IHabboSound
        {
            if (_SafeStr_614 != null)
            {
                return (addTraxSongForDownload(_arg_1, _arg_2));
            };
            var _local_3:TraxSequencer = createTraxInstance(_arg_1, _arg_2);
            if (!_local_3.ready)
            {
                _SafeStr_614 = _local_3;
                _loadingSongId = _arg_1;
            };
            return (_local_3 as IHabboSound);
        }

        private function addTraxSongForDownload(_arg_1:int, _arg_2:String):IHabboSound
        {
            var _local_3:TraxSequencer = createTraxInstance(_arg_1, _arg_2, false);
            if (!_local_3.ready)
            {
                _SafeStr_615.add(_arg_1, _local_3);
            };
            return (_local_3);
        }

        private function createTraxInstance(_arg_1:int, _arg_2:String, _arg_3:Boolean=true):TraxSequencer
        {
            var _local_5:TraxData = new TraxData(_arg_2);
            var _local_4:TraxSequencer = new TraxSequencer(_arg_1, _local_5, _SafeStr_612.traxSamples, events);
            _local_4.volume = _genericVolume;
            validateSampleAvailability(_local_4, _arg_3);
            return (_local_4);
        }

        private function validateSampleAvailability(_arg_1:TraxSequencer, _arg_2:Boolean):void
        {
            var _local_4:int;
            var _local_6:TraxData = _arg_1.traxData;
            var _local_5:Array = _local_6.getSampleIds();
            var _local_3:Boolean;
            _local_4 = 0;
            while (_local_4 < _local_5.length)
            {
                if (_SafeStr_612.traxSamples.getValue(_local_5[_local_4]) == null)
                {
                    if (_arg_2)
                    {
                        _SafeStr_612.loadSample(_local_5[_local_4]);
                    };
                    _local_3 = true;
                };
                _local_4++;
            };
            if (_local_3)
            {
                _arg_1.ready = false;
            }
            else
            {
                _arg_1.ready = true;
            };
        }

        public function notifyPlayedSong(_arg_1:String, _arg_2:String):void
        {
            if (_notifications == null)
            {
                return;
            };
            _notifications.addSongPlayingNotification(_arg_1, _arg_2);
        }

        private function onCommunicationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:IConnection;
            if (_arg_2 != null)
            {
                _communication = IHabboCommunicationManager(_arg_2);
                _local_3 = _communication.connection;
                if (_local_3 != null)
                {
                    onConnectionReady(_local_3);
                    init();
                };
            };
        }

        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            _roomEngine = IRoomEngine(_arg_2);
            init();
        }

        private function onNotificationsReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 == null)
            {
                return;
            };
            _notifications = IHabboNotifications(_arg_2);
        }

        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed)
            {
                return;
            };
            if (_arg_1 != null)
            {
                _connection = _arg_1;
            };
            init();
        }

        private function init():void
        {
            if ((((_connection == null) || (_roomEngine == null)) || (!(_musicController == null))))
            {
                return;
            };
            _musicController = new HabboMusicController(this, events, _roomEngine.events, _connection);
            _SafeStr_612 = new TraxSampleManager(this, onSampleLoadError);
            _onDemandSamplePlaybackManager = new FurniSamplePlaybackManager(this, _roomEngine.events);
            _roomEngine.events.addEventListener("REPSE_PLAY_SOUND", onRoomEngineObjectPlaySound);
            _roomEngine.events.addEventListener("REPSE_PLAY_SOUND_AT_PITCH", onRoomEngineObjectPlaySound);
            _connection.addMessageEvent(new AccountPreferencesEvent(onSoundSettingsEvent));
            _connection.send(new GetSoundSettingsComposer());
        }

        protected function setMusicController(_arg_1:IHabboMusicController):void
        {
            _musicController = _arg_1;
        }

        private function onTraxLoadComplete(_arg_1:Event):void
        {
            var _local_2:TraxSongLoadEvent = (_arg_1 as TraxSongLoadEvent);
            if (_local_2 == null)
            {
                return;
            };
            if (_SafeStr_614 == null)
            {
                return;
            };
            _SafeStr_614.ready = true;
            if (_musicController == null)
            {
                return;
            };
            _musicController.onSongLoaded(_local_2.id);
            _SafeStr_614 = null;
            _loadingSongId = -1;
        }

        private function storeVolumeSetting():void
        {
            if (_connection != null)
            {
                _connection.send(new SetSoundSettingsComposer((_traxVolume * 100), (_furniVolume * 100), (_genericVolume * 100)));
            };
        }

        private function updateVolumeSetting(_arg_1:Number, _arg_2:Number, _arg_3:Number):void
        {
            if (_SafeStr_616)
            {
                _genericVolume = 0;
                _furniVolume = 0;
                _traxVolume = 0;
                _musicController.updateVolume(0);
                _onDemandSamplePlaybackManager.updateVolume(0);
            }
            else
            {
                _genericVolume = _arg_1;
                _furniVolume = _arg_2;
                _traxVolume = _arg_3;
                _musicController.updateVolume(_arg_3);
                _onDemandSamplePlaybackManager.updateVolume(_arg_2);
            };
        }

        private function onSoundSettingsEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:AccountPreferencesEvent = (_arg_1 as AccountPreferencesEvent);
            var _local_2:AccountPreferencesParser = (_local_3.getParser() as AccountPreferencesParser);
            var _local_4:Number = _local_2.uiVolume;
            if (_local_4 == 1)
            {
                _local_4 = 100;
            };
            updateVolumeSetting((_local_4 / 100), (_local_2.furniVolume / 100), (_local_2.traxVolume / 100));
        }

        private function loadNextSong():void
        {
            var _local_2:int;
            var _local_1:TraxSequencer;
            if (((_SafeStr_614 == null) && (_SafeStr_615.length > 0)))
            {
                _local_2 = _SafeStr_615.getKey(0);
                _local_1 = _SafeStr_615.remove(_local_2);
                if (((!(_local_1 == null)) && (!(_local_1.disposed))))
                {
                    validateSampleAvailability(_local_1, true);
                    if (_local_1.ready)
                    {
                        events.dispatchEvent(new TraxSongLoadEvent("TSLE_TRAX_LOAD_COMPLETE", _local_2));
                    }
                    else
                    {
                        _SafeStr_614 = _local_1;
                        _loadingSongId = _local_2;
                    };
                };
            };
        }

        private function onRoomEngineObjectPlaySound(_arg_1:Event):void
        {
            var _local_2:RoomEngineObjectPlaySoundEvent = RoomEngineObjectPlaySoundEvent(_arg_1);
            if (_arg_1.type == "REPSE_PLAY_SOUND")
            {
                playSound(_local_2.soundId);
            };
            if (_arg_1.type == "REPSE_PLAY_SOUND_AT_PITCH")
            {
                playSoundAtPitch(_local_2.soundId, _local_2.pitch);
            };
        }

        public function update(_arg_1:uint):void
        {
            if (_SafeStr_612 != null)
            {
                _SafeStr_612.update(_arg_1);
            };
            loadNextSong();
        }

        public function mute(_arg_1:Boolean):void
        {
            _SafeStr_616 = _arg_1;
            updateVolumeSetting(_genericVolume, _furniVolume, _traxVolume);
        }


    }
}

