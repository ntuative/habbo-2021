package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreOwnerMessageEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetRoomChangedEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components._SafeStr_101;

    public class BuilderCatalogWidget extends CatalogWidget implements ICatalogWidget, IDisposable 
    {

        private var _catalog:HabboCatalog;
        private var _offer:IPurchasableOffer;
        private var _SafeStr_1541:YouAreOwnerMessageEvent;

        public function BuilderCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
            _SafeStr_1541 = new YouAreOwnerMessageEvent(onYouAreOwner);
            _catalog.connection.addMessageEvent(_SafeStr_1541);
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (((!(_catalog == null)) && (!(_catalog.connection == null))))
            {
                _catalog.connection.removeMessageEvent(_SafeStr_1541);
                _SafeStr_1541 = null;
                _catalog = null;
            };
            events.removeEventListener("SELECT_PRODUCT", onSelectProduct);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (_catalog.catalogType != "BUILDERS_CLUB")
            {
                _window.visible = false;
                return (true);
            };
            attachWidgetView("builderWidget");
            updateButtons(false);
            _window.procedure = windowProcedure;
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            events.addEventListener("CWE_ROOM_CHANGED", onRoomChanged);
            return (true);
        }

        private function onRoomChanged(_arg_1:CatalogWidgetRoomChangedEvent):void
        {
            updateButtons(false);
        }

        private function onYouAreOwner(_arg_1:YouAreOwnerMessageEvent):void
        {
            if (_catalog.catalogType != "BUILDERS_CLUB")
            {
                return;
            };
            updateButtons(true);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_CLICK")
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "place_one":
                    _catalog.requestSelectedItemToMover(null, _offer);
                    return;
                case "place_many":
                    _catalog.requestSelectedItemToMover(null, _offer, true);
                    return;
            };
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            _offer = _arg_1.offer;
            updateButtons(false);
        }

        private function updateButtons(_arg_1:Boolean):void
        {
            var _local_2:IStaticBitmapWrapperWindow;
            var _local_4:IWindow;
            if (((!(_window)) || (!(_window.visible))))
            {
                return;
            };
            var _local_3:int = _catalog.getBuilderFurniPlaceableStatus(_offer);
            if (((_local_3 == 4) && (_arg_1)))
            {
                _local_3 = 0;
            };
            if (_local_3 == 0)
            {
                _SafeStr_101(_window.findChildByName("place_one")).enable();
                _SafeStr_101(_window.findChildByName("place_many")).enable();
                _window.findChildByName("error_container").visible = false;
            }
            else
            {
                _SafeStr_101(_window.findChildByName("place_one")).disable();
                _SafeStr_101(_window.findChildByName("place_many")).disable();
                _window.findChildByName("error_container").visible = true;
                _local_2 = (_window.findChildByName("error_icon") as IStaticBitmapWrapperWindow);
                _local_4 = _window.findChildByName("error_message");
                switch (_local_3)
                {
                    case 1:
                        _window.findChildByName("error_container").visible = false;
                        return;
                    case 2:
                        _local_2.assetUri = "icons_builder_error_furnilimit";
                        _local_4.caption = "${builder.placement_widget.error.limit_reached}";
                        return;
                    case 3:
                        _local_2.assetUri = "icons_builder_error_notroom";
                        _local_4.caption = "${builder.placement_widget.error.not_in_room}";
                        return;
                    case 4:
                        _local_2.assetUri = "icons_builder_error_room";
                        _local_4.caption = "${builder.placement_widget.error.not_room_owner}";
                        return;
                    case 5:
                        _local_2.assetUri = "icons_builder_error_grouproom";
                        _local_4.caption = "${builder.placement_widget.error.group_room}";
                        return;
                    case 6:
                        _local_2.assetUri = "icons_builder_error_userinroom";
                        _local_4.caption = "${builder.placement_widget.error.visitors}";
                    default:
                };
            };
        }


    }
}

