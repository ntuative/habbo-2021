package com.sulake.habbo.toolbar.memenu
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.toolbar.ToolbarView;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;

    public class MeMenuController implements IDisposable 
    {

        public static const USE_GUIDE_TOOL:String = "USE_GUIDE_TOOL";

        private var _toolbar:HabboToolbar;
        private var _SafeStr_3795:ToolbarView;
        private var _window:IWindowContainer;
        private var _SafeStr_3797:MeMenuIconLoader;
        private var _SafeStr_3798:Boolean;
        private var _SafeStr_3799:MeMenuSettingsMenuView;
        private var _unseenItemCounters:Map;

        public function MeMenuController(_arg_1:HabboToolbar, _arg_2:ToolbarView)
        {
            _unseenItemCounters = new Map();
            _toolbar = _arg_1;
            _SafeStr_3795 = _arg_2;
            _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
            var _local_3:XmlAsset = (_toolbar.assets.getAssetByName("me_menu_view_xml") as XmlAsset);
            _window = (_toolbar.windowManager.buildFromXML((_local_3.content as XML), 2) as IWindowContainer);
            _SafeStr_3797 = new MeMenuIconLoader(_toolbar);
            _window.visible = false;
            _window.procedure = windowProcedure;
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_5:IRegionWindow;
            var _local_3:IStaticBitmapWrapperWindow;
            var _local_4:IHabboNavigator;
            var _local_6:String;
            if ((_arg_2 is IRegionWindow))
            {
                _local_5 = (_arg_2 as IRegionWindow);
                switch (_arg_1.type)
                {
                    case "WME_OVER":
                        _local_3 = (_local_5.findChildByName((_arg_2.name + "_icon")) as IStaticBitmapWrapperWindow);
                        if (_local_3 != null)
                        {
                            _local_3.assetUri = (("toolbar_memenu_" + _arg_2.name) + "_color");
                        };
                        return;
                    case "WME_OUT":
                        _local_3 = (_local_5.findChildByName((_arg_2.name + "_icon")) as IStaticBitmapWrapperWindow);
                        if (_local_3 != null)
                        {
                            _local_3.assetUri = (("toolbar_memenu_" + _arg_2.name) + "_white");
                        };
                        return;
                    case "WME_CLICK":
                        _window.visible = false;
                        switch (_arg_2.name)
                        {
                            case "profile":
                                _toolbar.connection.send(new GetExtendedProfileMessageComposer(_toolbar.sessionDataManager.userId));
                                break;
                            case "minimail":
                                HabboWebTools.openMinimail("#mail/inbox/");
                                break;
                            case "rooms":
                                _local_4 = _toolbar.navigator;
                                if (_local_4 != null)
                                {
                                    _local_4.showOwnRooms();
                                };
                                break;
                            case "talents":
                                _local_6 = _toolbar.sessionDataManager.currentTalentTrack;
                                _toolbar.connection.send(new GetTalentTrackMessageComposer(_local_6));
                                break;
                            case "settings":
                                _SafeStr_3799 = new MeMenuSettingsMenuView();
                                _SafeStr_3799.init(this, _SafeStr_3795);
                                break;
                            case "achievements":
                                _toolbar.questEngine.showAchievements();
                                break;
                            case "guide":
                                _toolbar.toggleWindowVisibility("GUIDE");
                                break;
                            case "clothes":
                                _toolbar.context.createLinkEvent("avatareditor/open");
                        };
                        return;
                };
            };
        }

        private function onToolbarClick(_arg_1:HabboToolbarEvent):void
        {
            if (_SafeStr_3798)
            {
                return;
            };
            if (_arg_1.iconId == "HTIE_ICON_MEMENU")
            {
                toggleVisibility();
            }
            else
            {
                _window.visible = false;
                if (_SafeStr_3799 != null)
                {
                    _SafeStr_3799.dispose();
                    _SafeStr_3799 = null;
                };
            };
        }

        private function setGuideToolVisibility(_arg_1:Boolean):void
        {
            _window.findChildByName("guide").visible = _arg_1;
            _window.height = ((_arg_1) ? (_window.findChildByName("guide").bottom + 5) : (_window.findChildByName("achievements").bottom + 5));
        }

        public function toggleVisibility():void
        {
            var _local_1:Boolean;
            if (_SafeStr_3799 != null)
            {
                _SafeStr_3799.dispose();
                _SafeStr_3799 = null;
            };
            _window.visible = (!(_window.visible));
            if (_window.visible)
            {
                if (!toolbar.getBoolean("talent.track.enabled"))
                {
                    _window.findChildByName("guide").rectangle = _window.findChildByName("talents").rectangle;
                    _window.findChildByName("talents").visible = false;
                };
                if (_toolbar.getBoolean("guides.enabled"))
                {
                    _local_1 = _toolbar.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL");
                    setGuideToolVisibility(_local_1);
                };
            };
            reposition();
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (_SafeStr_3799 != null)
            {
                _SafeStr_3799.dispose();
                _SafeStr_3799 = null;
            };
            _SafeStr_3797.dispose();
            _SafeStr_3797 = null;
            _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK", onToolbarClick);
            _SafeStr_3795 = null;
            _toolbar = null;
        }

        public function get disposed():Boolean
        {
            return (_toolbar == null);
        }

        public function get toolbar():HabboToolbar
        {
            return (_toolbar);
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        public function reposition():void
        {
            _window.x = (_SafeStr_3795.window.width + 10);
            _window.y = (_SafeStr_3795.window.bottom - _window.height);
        }

        public function getUnseenItemCounter(_arg_1:String):IWindowContainer
        {
            var _local_2:IWindowContainer;
            var _local_4:String = _arg_1;
            if (!_local_4)
            {
                Logger.log(("[Toolbar] Unknown icon type for unseen item counter for iconId: " + _arg_1));
            };
            var _local_3:IWindowContainer = (_unseenItemCounters.getValue(_arg_1) as IWindowContainer);
            if (!_local_3)
            {
                _local_3 = _toolbar.windowManager.createUnseenItemCounter();
                _local_2 = (_window.findChildByName(_local_4) as IWindowContainer);
                if (_local_2)
                {
                    _local_2.addChild(_local_3);
                    _local_3.x = ((_local_2.width - _local_3.width) - 5);
                    _local_3.y = 5;
                    _unseenItemCounters.add(_arg_1, _local_3);
                };
            };
            return (_local_3);
        }

        public function set achievementCount(_arg_1:int):void
        {
            setUnseenItemCount("achievements", _arg_1);
        }

        public function set minimailCount(_arg_1:int):void
        {
            setUnseenItemCount("minimail", _arg_1);
        }

        public function set newUiEnabled(_arg_1:Boolean):void
        {
            _SafeStr_3798 = _arg_1;
        }

        public function setUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IWindowContainer = getUnseenItemCounter(_arg_1);
            if (!_local_3)
            {
                return;
            };
            if (_arg_2 < 0)
            {
                _local_3.visible = true;
                _local_3.findChildByName("count").caption = " ";
            }
            else
            {
                if (_arg_2 > 0)
                {
                    _local_3.visible = true;
                    _local_3.findChildByName("count").caption = _arg_2.toString();
                }
                else
                {
                    _local_3.visible = false;
                };
            };
        }


    }
}

