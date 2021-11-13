package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.events.ILinkEventTracker;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.ui.IRoomUI;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.ComponentDependency;
    import com.sulake.iid.IIDCoreWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDCoreLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboRoomUI;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.enum._SafeStr_120;
    import com.sulake.habbo.ui.IRoomDesktop;
    import com.sulake.iid.*;

    public class HabboAvatarEditorManager extends Component implements IHabboAvatarEditor, ILinkEventTracker 
    {

        public static const _SafeStr_1414:uint = 1;
        public static const _SafeStr_1415:uint = 2;
        public static const _SafeStr_1416:uint = 3;
        private static const GENERIC:String = "generic";

        private var _windowManager:IHabboWindowManager;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _inventory:IHabboInventory;
        private var _localization:IHabboLocalizationManager;
        private var _communication:IHabboCommunicationManager;
        private var _catalog:IHabboCatalog;
        private var _sessionData:ISessionDataManager;
        private var _roomUI:IRoomUI;
        private var _handler:AvatarEditorMessageHandler;
        private var _editors:Map;

        public function HabboAvatarEditorManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            _editors = new Map();
        }

        override protected function get dependencies():Vector.<ComponentDependency>
        {
            return (super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreWindowManager(), function (_arg_1:IHabboWindowManager):void
            {
                _windowManager = _arg_1;
            }), new ComponentDependency(new IIDHabboCommunicationManager(), function (_arg_1:IHabboCommunicationManager):void
            {
                _communication = _arg_1;
            }, ((flags & 0x03) == 0)), new ComponentDependency(new IIDAvatarRenderManager(), function (_arg_1:IAvatarRenderManager):void
            {
                _avatarRenderManager = _arg_1;
            }, true, [{
                "type":"AVATAR_RENDER_READY",
                "callback":onAvatarRendererReady
            }]), new ComponentDependency(new IIDHabboInventory(), function (_arg_1:IHabboInventory):void
            {
                _inventory = _arg_1;
            }, ((flags & 0x01) == 0), []), new ComponentDependency(new IIDCoreLocalizationManager(), function (_arg_1:IHabboLocalizationManager):void
            {
                _localization = _arg_1;
            }), new ComponentDependency(new IIDHabboConfigurationManager(), null, true, [{
                "type":"complete",
                "callback":onConfigurationComplete
            }]), new ComponentDependency(new IIDHabboCatalog(), function (_arg_1:IHabboCatalog):void
            {
                _catalog = _arg_1;
            }, ((flags & 0x02) == 0)), new ComponentDependency(new IIDSessionDataManager(), function (_arg_1:ISessionDataManager):void
            {
                _sessionData = _arg_1;
            }), new ComponentDependency(new IIDHabboRoomUI(), function (_arg_1:IRoomUI):void
            {
                _roomUI = _arg_1;
            }, false)]));
        }

        private function onConfigurationComplete(_arg_1:Event):void
        {
        }

        override protected function initComponent():void
        {
            context.addLinkEventTracker(this);
            if (_communication)
            {
                _handler = new AvatarEditorMessageHandler(this, _communication);
            };
        }

        override public function dispose():void
        {
            if (_editors)
            {
                for each (var _local_1:HabboAvatarEditor in _editors)
                {
                    _local_1.dispose();
                    _local_1 = null;
                };
                _editors = null;
            };
            if (_handler != null)
            {
                _handler.dispose();
                _handler = null;
            };
            super.dispose();
        }

        public function openEditor(_arg_1:uint, _arg_2:IHabboAvatarEditorDataSaver, _arg_3:Array=null, _arg_4:Boolean=false, _arg_5:String=null, _arg_6:String="generic"):IFrameWindow
        {
            var _local_7:HabboAvatarEditor = _editors.getValue(_arg_1);
            if (!_local_7)
            {
                _local_7 = new HabboAvatarEditor(_arg_1, this);
                _editors.add(_arg_1, _local_7);
            };
            return (_local_7.openWindow(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }

        public function embedEditorToContext(_arg_1:uint, _arg_2:IWindowContainer, _arg_3:IHabboAvatarEditorDataSaver=null, _arg_4:Array=null, _arg_5:Boolean=false, _arg_6:Boolean=false):Boolean
        {
            var _local_7:HabboAvatarEditor = _editors.getValue(_arg_1);
            if (_local_7)
            {
                _local_7.dispose();
            };
            _local_7 = new HabboAvatarEditor(_arg_1, this, _arg_6);
            _editors.add(_arg_1, _local_7);
            _local_7.embedToContext(_arg_2, _arg_3, _arg_4, _arg_5);
            return (true);
        }

        public function loadAvatarInEditor(_arg_1:uint, _arg_2:String, _arg_3:String, _arg_4:int=0):void
        {
            var _local_5:HabboAvatarEditor = (_editors.getValue(_arg_1) as HabboAvatarEditor);
            if (_local_5)
            {
                return (_local_5.loadAvatarInEditor(_arg_2, _arg_3, _arg_4));
            };
        }

        public function loadOwnAvatarInEditor(_arg_1:uint):void
        {
            var _local_2:HabboAvatarEditor = (_editors.getValue(_arg_1) as HabboAvatarEditor);
            if (_local_2)
            {
                return (_local_2.loadAvatarInEditor(sessionData.figure, sessionData.gender, sessionData.clubLevel));
            };
        }

        public function close(_arg_1:uint):void
        {
            if (!_editors)
            {
                return;
            };
            var _local_2:HabboAvatarEditor = (_editors.getValue(_arg_1) as HabboAvatarEditor);
            if (!_local_2)
            {
                return;
            };
            if (!_SafeStr_120.isDevelopmentEditor(_arg_1))
            {
                _local_2.figureData.avatarEffectType = inventory.getLastActivatedEffect();
            };
            switch (_arg_1)
            {
                case 0:
                    _local_2.hide();
                    return;
                case 1:
                    _local_2.hide();
                    _local_2.dispose();
                    _editors.remove(_arg_1);
                    return;
                case 2:
                    return;
                default:
                    _local_2.dispose();
                    _editors.remove(_arg_1);
            };
        }

        public function getEditor(_arg_1:uint):HabboAvatarEditor
        {
            return (_editors.getValue(_arg_1) as HabboAvatarEditor);
        }

        public function get localization():IHabboLocalizationManager
        {
            return (_localization);
        }

        public function get windowManager():IHabboWindowManager
        {
            return (_windowManager);
        }

        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (_avatarRenderManager);
        }

        private function onAvatarRendererReady(_arg_1:Event=null):void
        {
            this.events.dispatchEvent(new Event("AVATAR_EDITOR_READY"));
        }

        public function get communication():IHabboCommunicationManager
        {
            return (_communication);
        }

        public function get handler():AvatarEditorMessageHandler
        {
            return (_handler);
        }

        public function get catalog():IHabboCatalog
        {
            return (_catalog);
        }

        public function get sessionData():ISessionDataManager
        {
            return (_sessionData);
        }

        public function get inventory():IHabboInventory
        {
            return (_inventory);
        }

        public function get roomDesktop():IRoomDesktop
        {
            return (_roomUI.getDesktop("hard_coded_room_id"));
        }

        public function get linkPattern():String
        {
            return ("avatareditor/");
        }

        public function linkReceived(_arg_1:String):void
        {
            var _local_2:Array = _arg_1.split("/");
            if (_local_2.length < 2)
            {
                return;
            };
            switch (_local_2[1])
            {
                case "open":
                    openEditor(0, null, null, true);
                    loadOwnAvatarInEditor(0);
                    return;
                default:
                    return;
            };
        }


    }
}

