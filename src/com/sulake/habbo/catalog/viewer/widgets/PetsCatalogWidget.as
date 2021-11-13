package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPaletteData;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import flash.geom.Matrix;

    public class PetsCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener
    {

        private var _offers:Map;
        private var _SafeStr_1585:int = -1;
        private var _SafeStr_1586:int = 0;
        private var _SafeStr_1594:int = 0;
        private var _SafeStr_1587:String;
        private var _SafeStr_1588:Boolean = false;
        private var _SafeStr_1589:Array;
        private var _availableColors:Array;
        private var _SafeStr_1381:Boolean = false;
        private var _catalog:HabboCatalog;
        private var _SafeStr_1590:IWindow;
        private var _SafeStr_1591:int = -1;
        private var _SafeStr_1584:IWindow;

        public function PetsCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1);
            _catalog = _arg_2;
        }

        override public function dispose():void
        {
            if (_SafeStr_1381)
            {
                return;
            };
            _SafeStr_1588 = false;
            _offers.dispose();
            _offers = null;
            _SafeStr_1589 = null;
            _availableColors = null;
            _catalog = null;
            _SafeStr_1590 = null;
            super.dispose();
            _SafeStr_1381 = true;
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            _SafeStr_1588 = false;
            var _local_2:IWindow = window.findChildByName("ctlg_buy_button");
            _SafeStr_1584 = window.findChildByName("name_input_text");
            if (_SafeStr_1584 == null)
            {
                return (false);
            };
            _SafeStr_1584.caption = "";
            _offers = new Map();
            if (page.offers.length == 0)
            {
                return (false);
            };
            var _local_1:IPurchasableOffer = page.offers[0];
            _SafeStr_1585 = getPetTypeIndexFromProduct(_local_1.localizationId);
            if (_SafeStr_1585 >= 8)
            {
                return (false);
            };
            updateAvailablePalettes(_local_1.localizationId);
            _SafeStr_1587 = _local_1.localizationId;
            updateAvailableColors();
            _offers.add(_SafeStr_1585, _local_1);
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            events.addEventListener("COLOUR_INDEX", onColourIndex);
            events.addEventListener("CWE_APPROVE_RESULT", onApproveNameResult);
            events.addEventListener("WIDGETS_INITIALIZED", onWidgetsInitialized);
            events.addEventListener("SELLABLE_PET_PALETTES", onSellablePetPalettes);
            return (true);
        }

        private function updateAvailableColors():void
        {
            _availableColors = [];
            if (_SafeStr_1585 == 0)
            {
                _availableColors = [16743226, 16750435, 16764339, 0xF59500, 16498012, 16704690, 0xEDD400, 16115545, 16513201, 8694111, 11585939, 14413767, 6664599, 9553845, 12971486, 8358322, 10002885, 13292268, 10780600, 12623573, 14403561, 12418717, 14327229, 15517403, 14515069, 15764368, 16366271, 0xABABAB, 0xD4D4D4, 0xFFFFFF, 14256481, 14656129, 15848130, 14005087, 14337152, 15918540, 15118118, 15531929, 9764857, 11258085];
            }
            else
            {
                if (_SafeStr_1585 == 1)
                {
                    _availableColors = [16743226, 16750435, 16764339, 0xF59500, 16498012, 16704690, 0xEDD400, 16115545, 16513201, 8694111, 11585939, 14413767, 6664599, 9553845, 12971486, 8358322, 10002885, 13292268, 10780600, 12623573, 14403561, 12418717, 14327229, 15517403, 14515069, 15764368, 16366271, 0xABABAB, 0xD4D4D4, 0xFFFFFF, 14256481, 14656129, 15848130, 14005087, 14337152, 15918540, 15118118, 15531929, 9764857, 11258085];
                }
                else
                {
                    if (_SafeStr_1585 == 2)
                    {
                        _availableColors = [16579283, 15378351, 8830016, 15257125, 9340985, 8949607, 6198292, 8703620, 9889626, 8972045, 12161285, 13162269, 8620113, 12616503, 8628101, 0xD2FF00, 9764857];
                    }
                    else
                    {
                        if (_SafeStr_1585 == 3)
                        {
                            _availableColors = [0xFFFFFF, 0xEEEEEE, 0xDDDDDD];
                        }
                        else
                        {
                            if (_SafeStr_1585 == 4)
                            {
                                _availableColors = [0xFFFFFF, 16053490, 15464440, 16248792, 15396319, 15007487];
                            }
                            else
                            {
                                if (_SafeStr_1585 == 5)
                                {
                                    _availableColors = [0xFFFFFF, 0xEEEEEE, 0xDDDDDD];
                                }
                                else
                                {
                                    if (_SafeStr_1585 == 6)
                                    {
                                        _availableColors = [0xFFFFFF, 0xEEEEEE, 0xDDDDDD, 16767177, 16770205, 16751331];
                                    }
                                    else
                                    {
                                        if (_SafeStr_1585 == 7)
                                        {
                                            _availableColors = [0xCCCCCC, 0xAEAEAE, 16751331, 10149119, 16763290, 16743786];
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function onWidgetsInitialized(_arg_1:CatalogWidgetEvent=null):void
        {
            if (_SafeStr_1381)
            {
                return;
            };
            events.dispatchEvent(new CatalogWidgetPurchaseOverrideEvent(onPurchase));
            var _local_2:Offer = _offers.getWithIndex(0);
            if (_local_2 != null)
            {
                events.dispatchEvent(new SelectProductEvent(_local_2));
            };
            var _local_4:Array = [];
            for each (var _local_3:int in _availableColors)
            {
                _local_4.push(_local_3);
            };
            events.dispatchEvent(new CatalogWidgetColoursEvent(_local_4, "ctlg_clr_27x22_1", "ctlg_clr_27x22_2", "ctlg_clr_27x22_3"));
        }

        private function onPurchase(_arg_1:WindowEvent):void
        {
            if (_SafeStr_1588)
            {
                Logger.log("* Cannot buy a pet, pending previous name approval.");
            };
            if (getPurchaseParameters() == "")
            {
                return;
            };
            _SafeStr_1588 = true;
            _catalog.approveName(_SafeStr_1584.caption, 1);
        }

        public function onDropMenuEvent(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:int;
            if (_arg_1.type == "WE_SELECTED")
            {
                _local_3 = IDropMenuWindow(_arg_2).selection;
                if (((_SafeStr_1589 == null) || (_local_3 >= _SafeStr_1589.length)))
                {
                    return;
                };
                _SafeStr_1586 = _local_3;
                updateImage();
            };
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            updateImage();
        }

        private function onColourIndex(_arg_1:CatalogWidgetColourIndexEvent):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            _SafeStr_1594 = _arg_1.index;
            if (((_SafeStr_1594 < 0) || (_SafeStr_1594 > _availableColors.length)))
            {
                _SafeStr_1594 = 0;
            };
            updateImage();
        }

        private function onApproveNameResult(_arg_1:CatalogWidgetApproveNameResultEvent):void
        {
            var event:CatalogWidgetApproveNameResultEvent = _arg_1;
            if (((event == null) || (!(_SafeStr_1588))))
            {
                return;
            };
            _SafeStr_1588 = false;
            var nameValidationInfo:String = event.nameValidationInfo;
            if (event.result != 0)
            {
                _catalog.purchaseWillBeGift(false);
            };
            switch (event.result)
            {
                case 1:
                    _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", constructErrorMessage("long", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 2:
                    _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", constructErrorMessage("short", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 3:
                    _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", constructErrorMessage("chars", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case 4:
                    _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", constructErrorMessage("bobba", nameValidationInfo), 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                default:
                    var extraParameter:String = getPurchaseParameters();
                    if (extraParameter == "")
                    {
                        Logger.log("* Not enough information to buy a pet!");
                        return;
                    };
                    Logger.log(("* Will buy pet as " + extraParameter));
                    _catalog.showPurchaseConfirmation(_offers.getWithIndex(0), page.pageId, extraParameter, 1, null, null, true, getPetImage());
                    return;
            };
        }

        private function constructErrorMessage(_arg_1:String, _arg_2:String):String
        {
            var _local_4:IHabboLocalizationManager = _catalog.localization;
            var _local_3:String = ("catalog.alert.petname." + _arg_1);
            var _local_6:String = (_local_3 + ".additionalInfo");
            _local_4.registerParameter(_local_6, "additional_info", _arg_2);
            var _local_7:String = _local_4.getLocalization(_local_3);
            var _local_5:String = _local_4.getLocalization(_local_6);
            if (((((!(_arg_2 == null)) && (_arg_2.length > 0)) && (!(_local_5 == null))) && (_local_5.length > 0)))
            {
                _local_7 = _local_5;
            };
            return (_local_7);
        }

        private function onSellablePetPalettes(_arg_1:CatalogWidgetSellablePetPalettesEvent):void
        {
            if (_arg_1.productCode == _SafeStr_1587)
            {
                _SafeStr_1589 = parseSellablePalettes(_arg_1.sellablePalettes);
                _SafeStr_1586 = 0;
                updatePaletteSelections();
            };
        }

        private function parseSellablePalettes(_arg_1:Array):Array
        {
            if (!_arg_1)
            {
                return (null);
            };
            var _local_2:Array = [];
            for each (var _local_3:SellablePetPaletteData in _arg_1)
            {
                if (((_local_3.type == _SafeStr_1585) && (_local_3.sellable)))
                {
                    _local_2.push(_local_3);
                };
            };
            return (_local_2);
        }

        private function updatePaletteSelections():void
        {
            var _local_4:int;
            var _local_3:SellablePetPaletteData;
            var _local_1:IHabboLocalizationManager = _catalog.localization;
            var _local_2:Array = [];
            _local_4 = 0;
            while (_local_4 < _SafeStr_1589.length)
            {
                _local_3 = (_SafeStr_1589[_local_4] as SellablePetPaletteData);
                _local_2.push(_local_1.getLocalization(getRaceLocalizationKey(_SafeStr_1585, _local_3.breedId), getRaceLocalizationKey(_SafeStr_1585, _local_3.breedId)));
                _local_4++;
            };
            var _local_5:IDropMenuWindow = (window.findChildByName("type_drop_menu") as IDropMenuWindow);
            if (_local_5 == null)
            {
                return;
            };
            if (_local_2.length > 1)
            {
                _local_5.populate(_local_2);
                _local_5.selection = 0;
                _local_5.procedure = onDropMenuEvent;
                _local_5.visible = true;
            }
            else
            {
                _local_5.visible = false;
            };
            updateImage();
        }

        private function getPetImage():BitmapData
        {
            var _local_1:Offer = _offers.getWithIndex(0);
            if (_local_1 == null)
            {
                return (null);
            };
            if (((_SafeStr_1589 == null) || (_SafeStr_1586 >= _SafeStr_1589.length)))
            {
                return (null);
            };
            var _local_2:int = 0xFFFFFF;
            if (((_SafeStr_1594 >= 0) && (_SafeStr_1594 < _availableColors.length)))
            {
                _local_2 = _availableColors[_SafeStr_1594];
            };
            var _local_4:int = _SafeStr_1585;
            var _local_3:SellablePetPaletteData = (_SafeStr_1589[_SafeStr_1586] as SellablePetPaletteData);
            var _local_5:int = _local_3.paletteId;
            var _local_6:_SafeStr_147 = _catalog.roomEngine.getPetImage(_local_4, _local_5, _local_2, new Vector3d(90, 0, 0), 64, this);
            if (_local_6 != null)
            {
                _SafeStr_1591 = _local_6.id;
                return (_local_6.data);
            };
            return (null);
        }

        private function updateImage():void
        {
            var _local_1:Offer = _offers.getWithIndex(0);
            if (((_local_1 == null) || (_SafeStr_1586 < 0)))
            {
                return;
            };
            var _local_2:BitmapData = getPetImage();
            if (_local_2 != null)
            {
                setPreviewImage(_local_2, true);
            };
            var _local_3:IWindow = window.findChildByName("ctlg_teaserimg_1");
            _SafeStr_1590 = _catalog.utils.showPriceOnProduct(_local_1, _window, _SafeStr_1590, _local_3, -6, false, 6);
        }

        private function getPurchaseParameters():String
        {
            var name:String = _SafeStr_1584.caption;
            if (((name == null) || (name.length == 0)))
            {
                _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}", "${catalog.alert.petname.empty}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return ("");
            };
            if (((_SafeStr_1589 == null) || (_SafeStr_1586 >= _SafeStr_1589.length)))
            {
                return ("");
            };
            if (_SafeStr_1594 >= _availableColors.length)
            {
                return ("");
            };
            var color:uint = _availableColors[_SafeStr_1594];
            var data:SellablePetPaletteData = (_SafeStr_1589[_SafeStr_1586] as SellablePetPaletteData);
            var paletteId:int = data.paletteId;
            var p:String = ((((name + String.fromCharCode(10)) + paletteId) + String.fromCharCode(10)) + addZeroPadding(color.toString(16).toUpperCase(), 6));
            return (p);
        }

        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_6:IBitmapWrapperWindow;
            var _local_5:int;
            var _local_3:BitmapData;
            var _local_4:Point;
            if (!window.disposed)
            {
                if (_arg_1 == null)
                {
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                _local_6 = (window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
                if (_local_6 != null)
                {
                    if (_local_6.bitmap == null)
                    {
                        _local_6.bitmap = new BitmapData(_local_6.width, _local_6.height, true, 0xFFFFFF);
                    };
                    _local_6.bitmap.fillRect(_local_6.bitmap.rect, 0xFFFFFF);
                    _local_5 = 2;
                    _local_3 = new BitmapData((_arg_1.width * _local_5), (_arg_1.height * _local_5), true, 0xFFFFFF);
                    _local_3.draw(_arg_1, new Matrix(_local_5, 0, 0, _local_5));
                    _local_4 = new Point(((_local_6.width - _local_3.width) / 2), ((_local_6.height - _local_3.height) / 2));
                    _local_6.bitmap.copyPixels(_local_3, _local_3.rect, _local_4, null, null, true);
                    _local_6.invalidate();
                    _local_3.dispose();
                };
            };
            if (_arg_2)
            {
                _arg_1.dispose();
            };
        }

        private function getPetTypeIndexFromProduct(_arg_1:String):int
        {
            if (_arg_1.length == 0)
            {
                return (0);
            };
            var _local_2:int;
            _local_2 = (_arg_1.length - 1);
            while (_local_2 >= 0)
            {
                if (isNaN(parseInt(_arg_1.charAt(_local_2)))) break;
                _local_2--;
            };
            if (_local_2 > 0)
            {
                return int((_arg_1.substring((_local_2 + 1))));
            };
            return (-1);
        }

        private function getRaceLocalizationKey(_arg_1:int, _arg_2:int):String
        {
            return ((("pet.breed." + _arg_1) + ".") + _arg_2);
        }

        private function addZeroPadding(_arg_1:String, _arg_2:int):String
        {
            while (_arg_1.length < _arg_2)
            {
                _arg_1 = ("0" + _arg_1);
            };
            return (_arg_1);
        }

        private function updateAvailablePalettes(_arg_1:String):void
        {
            var _local_2:Array;
            if (_SafeStr_1589 == null)
            {
                _local_2 = _catalog.getSellablePetPalettes(_arg_1);
                _SafeStr_1589 = parseSellablePalettes(_local_2);
                _SafeStr_1586 = 0;
                if (_SafeStr_1589 != null)
                {
                    updatePaletteSelections();
                };
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            if (_arg_1 == _SafeStr_1591)
            {
                setPreviewImage(_arg_2, true);
                onWidgetsInitialized();
            };
        }

        public function imageFailed(_arg_1:int):void
        {
        }


    }
}