package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.IHabboTransitionalNavigator;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.window.utils.IModalDialog;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomCategoryAndTradeSettingsComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class EnforceCategoryCtrl 
    {

        private var _navigator:IHabboTransitionalNavigator;
        private var _window:IFrameWindow;
        private var _SafeStr_1665:IModalDialog;
        private var _categorySelection:int = 0;
        private var _tradeModeSelection:int = 0;
        private var _SafeStr_2936:Array = [];

        public function EnforceCategoryCtrl(_arg_1:IHabboTransitionalNavigator)
        {
            _navigator = _arg_1;
        }

        public function show(_arg_1:int):void
        {
            close();
            _SafeStr_1665 = _navigator.windowManager.buildModalDialogFromXML((_navigator.assets.getAssetByName("enforce_category_xml").content as XML));
            _window = (_SafeStr_1665.rootWindow as IFrameWindow);
            _window.procedure = windowProcedure;
            _window.center();
            _window.findChildByName("header_button_close").visible = false;
            var _local_2:IDropMenuWindow = (_window.findChildByName("trade_mode") as IDropMenuWindow);
            var _local_5:Array = [];
            _local_5.push("${navigator.roomsettings.trade_not_allowed}");
            _local_5.push("${navigator.roomsettings.trade_not_with_Controller}");
            _local_5.push("${navigator.roomsettings.trade_allowed}");
            _local_2.populate(_local_5);
            _local_2.selection = 0;
            var _local_6:IDropMenuWindow = (_window.findChildByName("category") as IDropMenuWindow);
            _SafeStr_2936 = [];
            for each (var _local_7:FlatCategory in _navigator.data.visibleCategories)
            {
                if (((!(_local_7.automatic)) && ((!(_local_7.staffOnly)) || ((_local_7.staffOnly) && (_navigator.sessionData.hasSecurity(7))))))
                {
                    _SafeStr_2936.push(_local_7);
                };
            };
            var _local_3:Array = [];
            for each (var _local_4:FlatCategory in _SafeStr_2936)
            {
                _local_3.push(_local_4.visibleName);
            };
            _local_6.populate(_local_3);
            _local_6.selection = 0;
        }

        private function close():void
        {
            if (((_SafeStr_1665) && (_window)))
            {
                _SafeStr_1665.dispose();
                _SafeStr_1665 = null;
                _window = null;
            };
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "ok":
                        _local_3 = FlatCategory(_SafeStr_2936[Math.max(0, _categorySelection)]).nodeId;
                        _navigator.communication.connection.send(new UpdateRoomCategoryAndTradeSettingsComposer(_navigator.data.currentRoomId, _local_3, _tradeModeSelection));
                        close();
                };
            }
            else
            {
                if (_arg_1.type == "WE_SELECTED")
                {
                    switch (_arg_2.name)
                    {
                        case "category":
                            _categorySelection = IDropMenuWindow(_arg_2).selection;
                            return;
                        case "trade_mode":
                            _tradeModeSelection = IDropMenuWindow(_arg_2).selection;
                            return;
                    };
                };
            };
        }


    }
}

