package com.sulake.habbo.roomevents
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.iid.IIDSessionDataManager;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.room.IRoomEngineServices;
    import com.sulake.habbo.room.ISelectedRoomObjectData;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.RoomSessionEvent;

    public class HabboUserDefinedRoomEvents extends Component implements IHabboUserDefinedRoomEvents 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _userDefinedRoomEventsCtrl:UserDefinedRoomEventsCtrl;
        private var _SafeStr_457:IncomingMessages;
        private var _roomEngine:IRoomEngine;
        private var _roomSession:IRoomSession;
        private var _sessionDataManager:ISessionDataManager;
        private var _userName:String;

        public function HabboUserDefinedRoomEvents(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _userDefinedRoomEventsCtrl = new UserDefinedRoomEventsCtrl(this);
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }), new ComponentDependency(new IIDHabboWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDRoomEngine(), function (_arg_1:IRoomEngine):void
            {
                _roomEngine = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomSessionManager(), null, false, [{
                "type":"RSE_CREATED",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSE_STARTED",
                "callback":roomSessionStateEventHandler
            }, {
                "type":"RSE_ENDED",
                "callback":roomSessionStateEventHandler
            }]), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionDataManager = _arg_1;
            })]));
        }

        override protected function initComponent():void
        {
            _SafeStr_457 = new IncomingMessages(this);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_457 != null)
            {
                _SafeStr_457.dispose();
                _SafeStr_457 = null;
            };
            super.dispose();
        }

        public function stuffSelected(_arg_1:int, _arg_2:String):void
        {
            var _local_3:ISelectedRoomObjectData = (_roomEngine as IRoomEngineServices).getPlacedObjectData(roomId);
            if (((_local_3) && (_local_3.id == -(_arg_1))))
            {
                (_roomEngine as IRoomEngineServices).setPlacedObjectData(roomId, null);
                return;
            };
            _userDefinedRoomEventsCtrl.stuffSelected(_arg_1, _arg_2);
        }

        public function send(_arg_1:IMessageComposer, _arg_2:Boolean=false):void
        {
            _communication.connection.send(_arg_1);
        }

        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_4:IAsset;
            var _local_2:XmlAsset;
            var _local_3:IWindow;
            try
            {
                _local_4 = assets.getAssetByName((_arg_1 + "_xml"));
                _local_2 = XmlAsset(_local_4);
                _local_3 = _windowManager.buildFromXML(XML(_local_2.content));
            }
            catch(e:Error)
            {
            };
            return (_local_3);
        }

        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int, _arg_6:String=null):void
        {
            if (!_arg_6)
            {
                _arg_6 = _arg_2;
            };
            var _local_7:IBitmapWrapperWindow = (_arg_1.findChildByName(_arg_2) as IBitmapWrapperWindow);
            if (!_arg_3)
            {
                _local_7.visible = false;
            }
            else
            {
                prepareButton(_local_7, _arg_6, _arg_4, _arg_5);
                _local_7.visible = true;
            };
        }

        private function prepareButton(_arg_1:IBitmapWrapperWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            _arg_1.id = _arg_4;
            _arg_1.procedure = _arg_3;
            if (_arg_1.bitmap != null)
            {
                return;
            };
            _arg_1.bitmap = getButtonImage(_arg_2);
            _arg_1.width = _arg_1.bitmap.width;
            _arg_1.height = _arg_1.bitmap.height;
        }

        public function getButtonImage(_arg_1:String, _arg_2:String="_png"):BitmapData
        {
            var _local_4:String = (_arg_1 + _arg_2);
            var _local_6:IAsset = assets.getAssetByName(_local_4);
            var _local_5:BitmapDataAsset = BitmapDataAsset(_local_6);
            var _local_3:BitmapData = BitmapData(_local_5.content);
            return (_local_3.clone());
        }

        public function get userDefinedRoomEventsCtrl():UserDefinedRoomEventsCtrl
        {
            return (_userDefinedRoomEventsCtrl);
        }

        public function get roomEngine():IRoomEngine
        {
            return (_roomEngine);
        }

        private function roomSessionStateEventHandler(_arg_1:RoomSessionEvent):void
        {
            if (_roomEngine == null)
            {
                return;
            };
            switch (_arg_1.type)
            {
                case "RSE_CREATED":
                case "RSE_STARTED":
                case "RSE_ENDED":
                    _roomSession = _arg_1.session;
                    return;
            };
        }

        public function get roomId():int
        {
            return ((_roomSession) ? _roomSession.roomId : 0);
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function set userName(_arg_1:String):void
        {
            _userName = _arg_1;
        }

        public function get sessionDataManager():ISessionDataManager
        {
            return (_sessionDataManager);
        }


    }
}

