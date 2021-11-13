package com.sulake.habbo.nux
{
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOptions;
    import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsSelection;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGift;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftProduct;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class NuxGiftSelectionView implements IProductDataListener 
    {

        private var _frame:IFrameWindow;
        private var _SafeStr_659:HabboNuxDialogs;
        private var _SafeStr_3046:IWindowContainer;
        private var _SafeStr_3047:Vector.<NewUserExperienceGiftOptions>;
        private var _SafeStr_2516:int;
        private var _SafeStr_3048:Vector.<NewUserExperienceGetGiftsSelection>;

        public function NuxGiftSelectionView(_arg_1:HabboNuxDialogs, _arg_2:Vector.<NewUserExperienceGiftOptions>)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_3047 = _arg_2;
            _SafeStr_2516 = 0;
            _SafeStr_3048 = new Vector.<NewUserExperienceGetGiftsSelection>();
            if (((_SafeStr_659.sessionDataManager) && (_SafeStr_659.sessionDataManager.loadProductData(this))))
            {
                show();
            };
        }

        public function productDataReady():void
        {
            show();
        }

        public function dispose():void
        {
            if (_frame)
            {
                _frame.dispose();
                _frame = null;
            };
            _SafeStr_659 = null;
            _SafeStr_3046 = null;
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_659 == null);
        }

        private function hide():void
        {
            if (_SafeStr_659)
            {
                _SafeStr_659.destroyNuxOfferView();
            };
        }

        private function show():void
        {
            if (_frame != null)
            {
                _frame.dispose();
            };
            var _local_2:XmlAsset = (_SafeStr_659.assets.getAssetByName("nux_gift_selection_xml") as XmlAsset);
            _frame = (_SafeStr_659.windowManager.buildFromXML((_local_2.content as XML)) as IFrameWindow);
            if (_frame == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            var _local_1:IWindow = _frame.findChildByTag("close");
            if (_local_1)
            {
                _local_1.visible = false;
            };
            populateStep();
        }

        private function populateStep():void
        {
            var _local_6:int;
            var _local_2:NewUserExperienceGift;
            var _local_12:IWindowContainer;
            var _local_3:ITextWindow;
            var _local_9:_SafeStr_101;
            var _local_10:IWindowContainer;
            var _local_14:IStaticBitmapWrapperWindow;
            var _local_13:String;
            var _local_15:int;
            var _local_4:NewUserExperienceGiftProduct;
            var _local_16:String;
            var _local_8:String;
            var _local_11:IProductData;
            var _local_17:String;
            if (((!(_SafeStr_3047)) || (!(_SafeStr_3047.length))))
            {
                return;
            };
            var _local_1:NewUserExperienceGiftOptions = _SafeStr_3047[_SafeStr_2516];
            var _local_5:IItemListWindow = (_frame.findChildByName("nux_gift_selection_list") as IItemListWindow);
            if (!_SafeStr_3046)
            {
                _SafeStr_3046 = (_local_5.getListItemAt(0) as IWindowContainer);
            };
            _local_5.removeListItems();
            var _local_7:String = decodeURI(_SafeStr_659.localizationManager.getLocalization("nux.gift.selection.separator", ", "));
            _local_6 = 0;
            while (_local_6 < _local_1.options.length)
            {
                _local_2 = _local_1.options[_local_6];
                _local_12 = (_SafeStr_3046.clone() as IWindowContainer);
                _local_3 = (_local_12.getChildByName("option_heading") as ITextWindow);
                _local_9 = (_local_12.getChildByName("option_button") as _SafeStr_101);
                _local_10 = (_local_12.getChildByName("option_thumbnail") as IWindowContainer);
                _local_14 = (_local_10.getChildByName("option_bitmap") as IStaticBitmapWrapperWindow);
                _local_13 = "";
                if (_local_2.productOfferList.length)
                {
                    _local_15 = 0;
                    while (_local_15 < _local_2.productOfferList.length)
                    {
                        _local_4 = _local_2.productOfferList[_local_15];
                        _local_16 = _local_4.productCode;
                        _local_8 = _local_4.localizationKey;
                        if (_local_8 != null)
                        {
                            _local_13 = (_local_13 + _SafeStr_659.localizationManager.getLocalization(_local_8, _local_8));
                        }
                        else
                        {
                            _local_11 = _SafeStr_659.catalog.getProductData(_local_16);
                            if (((_local_11) && (_local_11.name)))
                            {
                                _local_13 = (_local_13 + _local_11.name);
                            }
                            else
                            {
                                _local_13 = (_local_13 + _SafeStr_659.localizationManager.getLocalization((("product_" + _local_16) + "_name"), (("product_" + _local_16) + "_name")));
                            };
                        };
                        if (_local_15 < (_local_2.productOfferList.length - 1))
                        {
                            _local_13 = (_local_13 + _local_7);
                        };
                        _local_15++;
                    };
                };
                _local_17 = _local_2.thumbnailUrl;
                if (_local_17)
                {
                    _local_14.assetUri = (_SafeStr_659.configuration.getProperty("image.library.url") + _local_17);
                };
                _local_3.text = _local_13;
                _local_9.name = _local_6.toString();
                _local_9.procedure = onSelectOption;
                _local_5.addListItem(_local_12);
                _local_6++;
            };
            _local_5.arrangeListItems();
            if (_SafeStr_3047.length > 1)
            {
                _frame.caption = ((((_SafeStr_659.localizationManager.getLocalization("nux.gift.selection.title") + " ") + (_SafeStr_2516 + 1)) + "/") + _SafeStr_3047.length);
            };
            _frame.center();
        }

        private function onSelectOption(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:NewUserExperienceGiftOptions;
            var _local_6:IItemListWindow;
            var _local_4:int;
            var _local_5:NewUserExperienceGetGiftsSelection;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = _SafeStr_3047[_SafeStr_2516];
                _local_6 = (_frame.findChildByName("nux_gift_selection_list") as IItemListWindow);
                _local_4 = _local_6.getListItemIndex(_arg_2.parent);
                if (_local_4 == -1)
                {
                    return;
                };
                _local_5 = new NewUserExperienceGetGiftsSelection(_local_3.dayIndex, _local_3.stepIndex, _local_4);
                _SafeStr_3048.push(_local_5);
                _SafeStr_2516++;
                if (_SafeStr_2516 == _SafeStr_3047.length)
                {
                    _SafeStr_659.onSendGetGifts(_SafeStr_3048);
                }
                else
                {
                    show();
                };
            };
        }

        private function onClose(_arg_1:WindowMouseEvent):void
        {
            hide();
        }


    }
}

