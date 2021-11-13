package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class MeMenuDanceView implements IMeMenuView 
    {

        private var _SafeStr_1324:MeMenuWidget;
        private var _window:IWindowContainer;


        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            _SafeStr_1324 = _arg_1;
            createWindow(_arg_2);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (_window);
        }

        private function createWindow(_arg_1:String):void
        {
            var _local_7:int;
            var _local_5:Boolean;
            var _local_2:IWindow;
            var _local_6:XmlAsset = (_SafeStr_1324.assets.getAssetByName("memenu_dance") as XmlAsset);
            if (_local_6)
            {
                _window = (_SafeStr_1324.windowManager.buildFromXML((_local_6.content as XML)) as IWindowContainer);
            };
            if (_window == null)
            {
                throw (new Error("Failed to construct dance view window from XML!"));
            };
            _window.name = _arg_1;
            var _local_3:Array = [];
            _local_3.push(_window.findChildByName("stop_dancing_button"));
            _local_3.push(_window.findChildByName("back_btn"));
            for each (_local_2 in _local_3)
            {
                if (_local_2 != null)
                {
                    _local_2.addEventListener("WME_CLICK", onButtonClicked);
                };
            };
            var _local_8:IItemListWindow = (_window.findChildByName("buttonContainer") as IItemListWindow);
            var _local_4:XmlAsset = (_SafeStr_1324.assets.getAssetByName("memenu_dance_button") as XmlAsset);
            if (_local_8 != null)
            {
                _local_7 = 1;
                while (_local_7 <= 4)
                {
                    _local_5 = false;
                    if (RoomWidgetDanceMessage._SafeStr_632.indexOf(_local_7) >= 0)
                    {
                        _local_5 = _SafeStr_1324.allowHabboClubDances;
                    }
                    else
                    {
                        _local_5 = true;
                    };
                    if (_local_5)
                    {
                        _local_2 = (_SafeStr_1324.windowManager.buildFromXML((_local_4.content as XML)) as IWindow);
                        _local_2.name = (("dance_" + _local_7) + "_button");
                        _local_2.caption = (("${widget.memenu.dance" + _local_7) + "}");
                        _local_2.addEventListener("WME_CLICK", onButtonClicked);
                        _local_8.addListItemAt(_local_2, (_local_8.numListItems - 1));
                        if (_SafeStr_1324.hasEffectOn)
                        {
                            _local_2.disable();
                        }
                        else
                        {
                            _local_2.enable();
                        };
                    };
                    _local_7++;
                };
            };
            var _local_9:IWindow = _window.findChildByName("club_info");
            if (((!(_local_9 == null)) && (_SafeStr_1324.isHabboClubActive)))
            {
                _local_9.visible = false;
            };
        }

        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_5:Array;
            var _local_3:int;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_4:String = _local_2.name;
            switch (_local_4)
            {
                case "dance_1_button":
                case "dance_2_button":
                case "dance_3_button":
                case "dance_4_button":
                    _local_5 = _local_4.split("_");
                    _local_3 = parseInt(_local_5[1]);
                    _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(_local_3));
                    _SafeStr_1324.isDancing = true;
                    _SafeStr_1324.hide();
                    HabboTracking.getInstance().trackEventLog("MeMenu", "click", "dance_start");
                    return;
                case "stop_dancing_button":
                    _SafeStr_1324.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(0));
                    _SafeStr_1324.isDancing = false;
                    _SafeStr_1324.hide();
                    HabboTracking.getInstance().trackEventLog("MeMenu", "click", "dance_stop");
                    return;
                case "back_btn":
                    _SafeStr_1324.changeView("me_menu_top_view");
                    return;
                default:
                    Logger.log(("Me Menu Dance View: unknown button: " + _local_4));
                    return;
            };
        }

        public function updateUnseenItemCount(_arg_1:String, _arg_2:int):void
        {
        }


    }
}

