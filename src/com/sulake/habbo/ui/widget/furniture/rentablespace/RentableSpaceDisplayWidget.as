package com.sulake.habbo.ui.widget.furniture.rentablespace
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.handler.FurnitureRentableSpaceWidgetHandler;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.utils.FriendlyTime;
    import com.sulake.core.window.components.IItemListWindow;

    public class RentableSpaceDisplayWidget extends RoomWidgetBase 
    {

        private static var _SafeStr_4128:Dictionary = new Dictionary();

        private var _mainWindow:IWindowContainer;
        private var _roomObject:IRoomObject;

        {
            _SafeStr_4128[100] = "${rentablespace.widget.error_reason_already_rented}";
            _SafeStr_4128[101] = "${rentablespace.widget.error_reason_not_rented}";
            _SafeStr_4128[102] = "${rentablespace.widget.error_reason_not_rented_by_you}";
            _SafeStr_4128[103] = "${rentablespace.widget.error_reason_can_rent_only_one_space}";
            _SafeStr_4128[200] = "${rentablespace.widget.error_reason_not_enough_credits}";
            _SafeStr_4128[201] = "${rentablespace.widget.error_reason_not_enough_duckets}";
            _SafeStr_4128[202] = "${rentablespace.widget.error_reason_no_permission}";
            _SafeStr_4128[203] = "${rentablespace.widget.error_reason_no_habboclub}";
            _SafeStr_4128[300] = "${rentablespace.widget.error_reason_disabled}";
            _SafeStr_4128[400] = "${rentablespace.widget.error_reason_generic}";
        }

        public function RentableSpaceDisplayWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            ownHandler.widget = this;
        }

        private function get ownHandler():FurnitureRentableSpaceWidgetHandler
        {
            return (_SafeStr_3915 as FurnitureRentableSpaceWidgetHandler);
        }

        public function hide(_arg_1:IRoomObject):void
        {
            if (_roomObject != _arg_1)
            {
                return;
            };
            if (_mainWindow != null)
            {
                _mainWindow.dispose();
                _mainWindow = null;
            };
            _roomObject = null;
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            hide(_roomObject);
            super.dispose();
        }

        override public function get mainWindow():IWindow
        {
            return (_mainWindow);
        }

        public function show(_arg_1:IRoomObject):void
        {
            _roomObject = _arg_1;
            updateWidgetState();
        }

        private function createWindow():void
        {
            if (_mainWindow != null)
            {
                return;
            };
            _mainWindow = (windowManager.buildFromXML(XML(assets.getAssetByName("rentablespace_xml").content)) as IWindowContainer);
            _mainWindow.procedure = windowProcedure;
            _mainWindow.center();
            _mainWindow.findChildByName("rent_button").disable();
            _mainWindow.findChildByName("rented_view").visible = false;
            _mainWindow.findChildByName("error_view").visible = false;
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            switch (_arg_1.type)
            {
                case "WME_CLICK":
                    switch (_arg_2.name)
                    {
                        case "header_button_close":
                        case "error_button_close":
                            hide(_roomObject);
                            break;
                        case "rent_button":
                            ownHandler.rentSpace(_roomObject.getId());
                            break;
                        case "cancel_rent_button":
                            ownHandler.cancelRent(_roomObject.getId());
                    };
                    return;
            };
        }

        public function updateWidgetState():void
        {
            if (_roomObject == null)
            {
                return;
            };
            ownHandler.getRentableSpaceStatus(_roomObject.getId());
        }

        public function populateRentInfo(_arg_1:Boolean, _arg_2:Boolean, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:int, _arg_7:int):void
        {
            var _local_8:Boolean;
            if (_roomObject == null)
            {
                return;
            };
            createWindow();
            if (_arg_1)
            {
                _mainWindow.findChildByName("rent_view").visible = false;
                _mainWindow.findChildByName("error_view").visible = false;
                _mainWindow.findChildByName("rented_view").visible = true;
                _mainWindow.findChildByName("renter_name").caption = _arg_5;
                _mainWindow.findChildByName("time_remaining_label").caption = FriendlyTime.getFriendlyTime(ownHandler.container.localization, _arg_6);
                _mainWindow.findChildByName("cancel_rent_button").visible = ((ownHandler.container.isOwnerOfFurniture(_roomObject)) || (ownHandler.container.sessionDataManager.hasSecurity(5)));
                IItemListWindow(_mainWindow.findChildByName("rented_view")).arrangeListItems();
            }
            else
            {
                _mainWindow.findChildByName("rented_view").visible = false;
                _mainWindow.findChildByName("error_view").visible = false;
                _mainWindow.findChildByName("rent_view").visible = true;
                _mainWindow.findChildByName("price_label").caption = (_arg_7.toString() + " x");
                _local_8 = (_arg_7 <= ownHandler.getUsersCreditAmount());
                if (!_arg_2)
                {
                    _mainWindow.findChildByName("cant_rent_error").caption = _SafeStr_4128[_arg_3];
                }
                else
                {
                    if (!_local_8)
                    {
                        _mainWindow.findChildByName("cant_rent_error").caption = _SafeStr_4128[200];
                    }
                    else
                    {
                        _mainWindow.findChildByName("cant_rent_error").visible = false;
                        _mainWindow.findChildByName("rent_button").enable();
                    };
                };
                IItemListWindow(_mainWindow.findChildByName("rent_view")).arrangeListItems();
            };
            if (!_mainWindow.visible)
            {
                _mainWindow.visible = true;
            };
        }

        public function showErrorView(_arg_1:int):void
        {
            _mainWindow.findChildByName("rent_view").visible = false;
            _mainWindow.findChildByName("rented_view").visible = false;
            _mainWindow.findChildByName("error_view").visible = true;
            _mainWindow.findChildByName("error_message").caption = _SafeStr_4128[_arg_1];
        }


    }
}

