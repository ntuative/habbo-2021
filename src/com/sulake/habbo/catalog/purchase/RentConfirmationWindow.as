package com.sulake.habbo.catalog.purchase
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room._SafeStr_147;
    import com.sulake.habbo.communication.messages.parser.room.furniture.FurniRentOrBuyoutOfferMessageParser;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetRentOrBuyoutOfferMessageComposer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutFurniMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutStripItemMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;

    public class RentConfirmationWindow implements IDisposable, IGetImageListener 
    {

        private static const MODE_INFOSTAND:int = 1;
        private static const MODE_INVENTORY:int = 2;
        private static const MODE_CATALOGUE:int = 3;

        private var _disposed:Boolean;
        private var _offerMessageEvent:FurniRentOrBuyoutOfferMessageEvent;
        private var _window:IWindowContainer;
        private var _isBuyout:Boolean;
        private var _SafeStr_698:int = -1;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1492:IFurnitureData;
        private var _SafeStr_1493:int;
        private var _SafeStr_1494:int = -1;
        private var _SafeStr_1495:int;

        public function RentConfirmationWindow(_arg_1:HabboCatalog)
        {
            _catalog = _arg_1;
            _offerMessageEvent = new FurniRentOrBuyoutOfferMessageEvent(onFurniRentOrBuyoutOffer);
            _catalog.connection.addMessageEvent(_offerMessageEvent);
        }

        private function onFurniRentOrBuyoutOffer(_arg_1:FurniRentOrBuyoutOfferMessageEvent):void
        {
            var _local_3:_SafeStr_147;
            if (_SafeStr_1492 == null)
            {
                return;
            };
            var _local_2:FurniRentOrBuyoutOfferMessageParser = _arg_1.getParser();
            if (_SafeStr_1492.fullName != _local_2.furniTypeName)
            {
                return;
            };
            _isBuyout = _local_2.buyout;
            if (_catalog.getPurse().credits < _local_2.priceInCredits)
            {
                _catalog.showNotEnoughCreditsAlert();
                return;
            };
            if (_catalog.getPurse().getActivityPointsForType(_local_2.activityPointType) < _local_2.priceInActivityPoints)
            {
                _catalog.showNotEnoughActivityPointsAlert(_local_2.activityPointType);
                return;
            };
            _window = (_catalog.windowManager.buildFromXML((_catalog.assets.getAssetByName("rent_confirmation").content as XML)) as IWindowContainer);
            if (_local_2.priceInCredits > 0)
            {
                _window.findChildByName("price_amount").caption = _local_2.priceInCredits.toString();
                IStaticBitmapWrapperWindow(_window.findChildByName("price_type")).assetUri = "toolbar_credit_icon_0";
            }
            else
            {
                _window.findChildByName("price_amount").caption = _local_2.priceInActivityPoints.toString();
            };
            if (_isBuyout)
            {
                _window.caption = "${rent.confirmation.title.buyout}";
                _window.findChildByName("rental_description").visible = false;
                _window.findChildByName("ok_button").caption = "${catalog.purchase_confirmation.buy}";
            };
            _window.findChildByName("furni_name").caption = _SafeStr_1492.localizedName;
            IItemListWindow(_window.findChildByName("content_list")).arrangeListItems();
            _window.center();
            _window.procedure = windowProcedure;
            switch (_SafeStr_1492.type)
            {
                case "s":
                    _local_3 = roomEngine.getFurnitureImage(_SafeStr_1492.id, new Vector3d(90, 0, 0), 64, this);
                    break;
                case "i":
                    _local_3 = roomEngine.getWallItemImage(_SafeStr_1492.id, new Vector3d(90, 0, 0), 64, this);
            };
            IBitmapWrapperWindow(_window.findChildByName("image")).bitmap = _local_3.data;
            _SafeStr_698 = _local_3.id;
        }

        public function dispose():void
        {
            if (_disposed)
            {
                return;
            };
            close();
            if (_offerMessageEvent != null)
            {
                _catalog.connection.removeMessageEvent(_offerMessageEvent);
                _offerMessageEvent = null;
            };
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function show(_arg_1:IFurnitureData, _arg_2:Boolean, _arg_3:int=-1, _arg_4:int=-1, _arg_5:Boolean=false):void
        {
            close();
            _SafeStr_1492 = _arg_1;
            _SafeStr_1494 = _arg_3;
            _SafeStr_1495 = _arg_4;
            if (_arg_5)
            {
                _SafeStr_1493 = 3;
            }
            else
            {
                if (_SafeStr_1494 > -1)
                {
                    _SafeStr_1493 = 1;
                }
                else
                {
                    _SafeStr_1493 = 2;
                };
            };
            var _local_6:Boolean = (_arg_1.type == "i");
            _catalog.connection.send(new GetRentOrBuyoutOfferMessageComposer(_local_6, _arg_1.fullName, _arg_2));
        }

        private function get roomEngine():IRoomEngine
        {
            return (_catalog.roomEngine);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1.type == "WME_CLICK")) || (_window == null)))
            {
                return;
            };
            switch (_arg_2.name)
            {
                case "cancel_button":
                case "header_button_close":
                    close();
                    return;
                case "ok_button":
                    switch (_SafeStr_1493)
                    {
                        case 1:
                            _catalog.connection.send(new ExtendRentOrBuyoutFurniMessageComposer((_SafeStr_1492.type == "i"), _SafeStr_1494, _isBuyout));
                            break;
                        case 2:
                            _catalog.connection.send(new ExtendRentOrBuyoutStripItemMessageComposer(_SafeStr_1495, _isBuyout));
                            break;
                        case 3:
                            _catalog.purchaseOffer(_SafeStr_1492.rentOfferId);
                        default:
                    };
                    close();
                    return;
            };
        }

        private function close():void
        {
            if (_window == null)
            {
                return;
            };
            _window.dispose();
            _window = null;
            _SafeStr_698 = -1;
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (((!(_window == null)) && (_arg_1 == _SafeStr_698)))
            {
                IBitmapWrapperWindow(_window.findChildByName("image")).bitmap = _arg_2;
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}

