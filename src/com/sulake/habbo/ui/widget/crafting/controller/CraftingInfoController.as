package com.sulake.habbo.ui.widget.crafting.controller
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.room._SafeStr_147;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;

    public class CraftingInfoController implements IGetImageListener 
    {

        private static const DEBUG_PROGRESSBAR_TESTING_MODE:Boolean = false;

        private var _SafeStr_1324:CraftingWidget;
        private var _SafeStr_3143:CraftingProgressBarController;

        public function CraftingInfoController(_arg_1:CraftingWidget)
        {
            _SafeStr_1324 = _arg_1;
            _SafeStr_3143 = new CraftingProgressBarController(_arg_1);
        }

        public function dispose():void
        {
            _SafeStr_1324 = null;
            if (_SafeStr_3143)
            {
                _SafeStr_3143.dispose();
                _SafeStr_3143 = null;
            };
        }

        public function setState(_arg_1:int, ... _args):void
        {
            var _local_9:int;
            var _local_6:Vector.<String> = undefined;
            var _local_4:Array;
            var _local_7:IFurnitureData;
            var _local_10:ITextWindow;
            var _local_5:String = "";
            var _local_8:String = "";
            if ((((_args is Array) && (_args.length)) && (_args[0] is Array)))
            {
                _local_4 = _args[0];
            }
            else
            {
                _local_4 = _args;
            };
            var _local_3:IHabboLocalizationManager = _SafeStr_1324.handler.container.localization;
            switch (_arg_1)
            {
                case 0:
                    _local_5 = "${crafting.info.start}";
                    setButtonVisible(false);
                    break;
                case 1:
                    clearIcon();
                    _local_5 = "${crafting.info.mixer.empty}";
                    disableButtonWith("${crafting.status.mixer.notavailable}");
                    break;
                case 6:
                    clearIcon();
                    _local_5 = "${crafting.info.product.empty}";
                    setButtonVisible(false);
                    break;
                case 3:
                    clearIcon();
                    _local_5 = "${crafting.info.mixer.hit}";
                    enableButton();
                    break;
                case 4:
                    clearIcon();
                    _local_9 = (_local_4[0] as int);
                    _local_5 = _local_3.getLocalization("crafting.info.mixer.hit.plus.others", "crafting.info.mixer.hit.plus.others");
                    _local_5 = _local_5.replace("%number%", _local_9);
                    enableButton();
                    break;
                case 5:
                    clearIcon();
                    _local_9 = (_local_4[0] as int);
                    _local_5 = _local_3.getLocalization("crafting.info.mixer.others");
                    _local_5 = _local_5.replace("%number%", _local_9);
                    disableButtonWith("${crafting.status.mixer.notavailable}");
                    break;
                case 2:
                    clearIcon();
                    _local_5 = "${crafting.info.mixer.nohit}";
                    disableButtonWith("${crafting.status.mixer.notavailable}");
                    break;
                case 8:
                    _local_7 = (_local_4[0] as IFurnitureData);
                    if (!_local_7)
                    {
                        return;
                    };
                    requestIconFromRoomEngine(_local_7);
                    _local_5 = _local_3.getLocalization("crafting.info.product.complete", "crafting.info.product.complete");
                    _local_8 = _local_7.localizedName;
                    enableButton();
                    break;
                case 7:
                    _local_7 = (_local_4[0] as IFurnitureData);
                    if (!_local_7)
                    {
                        return;
                    };
                    requestIconFromRoomEngine(_local_7);
                    _local_6 = (_local_4[1] as Vector.<String>);
                    _local_5 = _local_3.getLocalization("crafting.info.product.incomplete", "crafting.info.product.incomplete");
                    _local_8 = _local_7.localizedName;
                    disableButtonWith("${crafting.status.recipe.incomplete}");
                    break;
                case 9:
                    _local_7 = (_local_4[0] as IFurnitureData);
                    if (!_local_7)
                    {
                        return;
                    };
                    requestIconFromRoomEngine(_local_7);
                    _local_5 = _local_3.getLocalization("crafting.info.mixer.notininventory", "crafting.info.mixer.notininventory");
                    _local_5 = _local_5.replace("%product%", _local_7.localizedName);
                    break;
                case 999:
                    _local_7 = (_local_4[0] as IFurnitureData);
                    if (!_local_7)
                    {
                        return;
                    };
                    requestIconFromRoomEngine(_local_7);
                    _local_5 = _local_3.getLocalization("crafting.info.result.ok", "crafting.info.result.ok");
                    _local_8 = _local_7.localizedName;
                    setButtonVisible(false);
                    break;
                case 1000:
                    _local_5 = "${crafting.info.working}";
                    setButtonVisible(false);
            };
            _local_10 = (mainWindow.findChildByName("info_text1") as ITextWindow);
            if (_local_10)
            {
                _local_10.text = _local_5;
            };
            _local_10 = (mainWindow.findChildByName("info_text2") as ITextWindow);
            if (_local_10)
            {
                _local_10.text = _local_8;
            };
        }

        private function enableButton():void
        {
            setButtonVisible(true);
            var _local_1:_SafeStr_101 = ((mainWindow) ? (mainWindow.findChildByName("btn_craft") as _SafeStr_101) : null);
            if (_SafeStr_1324.handler.isOwner)
            {
                _local_1.caption = "${crafting.btn.craft}";
                _local_1.enable();
                _local_1.procedure = onCraftTriggered;
            }
            else
            {
                _local_1.caption = "${crafting.btn.notowner}";
                _local_1.disable();
            };
        }

        private function disableButtonWith(_arg_1:String):void
        {
            setButtonVisible(true);
            var _local_2:_SafeStr_101 = ((mainWindow) ? (mainWindow.findChildByName("btn_craft") as _SafeStr_101) : null);
            if (_SafeStr_1324.handler.isOwner)
            {
                _local_2.caption = _arg_1;
            }
            else
            {
                _local_2.caption = "${crafting.btn.notowner}";
            };
            _local_2.disable();
        }

        public function craftingSecretRecipesAvailable(_arg_1:int, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                if (_arg_1 == 0)
                {
                    setState(3);
                }
                else
                {
                    setState(4, _arg_1);
                };
            }
            else
            {
                if (_arg_1 > 0)
                {
                    setState(5, _arg_1);
                }
                else
                {
                    setState(2);
                };
            };
        }

        private function onCraftTriggered(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != "WME_DOWN")
            {
                return;
            };
            showProgressBar();
        }

        private function clearIcon():void
        {
            setIconBitmapData(null);
            alignElements();
        }

        private function requestIconFromRoomEngine(_arg_1:IFurnitureData):void
        {
            var _local_2:_SafeStr_147;
            switch (_arg_1.type)
            {
                case "s":
                    _local_2 = _SafeStr_1324.handler.container.roomEngine.getFurnitureIcon(_arg_1.id, this);
                    break;
                case "i":
                    _local_2 = _SafeStr_1324.handler.container.roomEngine.getWallItemIcon(_arg_1.id, this);
            };
            if (_local_2.data)
            {
                imageReady(0, _local_2.data);
            };
        }

        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            setIconBitmapData(_arg_2);
            alignElements();
        }

        public function imageFailed(_arg_1:int):void
        {
            setIconBitmapData(null);
            alignElements();
        }

        private function alignElements():void
        {
        }

        private function showProgressBar():void
        {
            _SafeStr_1324.handler.craftingInProgress = true;
            setButtonVisible(false);
            _SafeStr_3143.show();
        }

        public function cancelCrafting():void
        {
            _SafeStr_1324.handler.craftingInProgress = false;
            _SafeStr_3143.hide();
            setButtonVisible(true);
        }

        public function onProgressBarComplete():void
        {
            _SafeStr_3143.hide();
            _SafeStr_1324.doCrafting();
        }

        private function setIconBitmapData(_arg_1:BitmapData):void
        {
            var _local_2:IBitmapWrapperWindow = ((mainWindow) ? IBitmapWrapperWindow(mainWindow.findChildByName("furniture_icon")) : null);
            if (!_local_2)
            {
                return;
            };
            _local_2.bitmap = _arg_1;
        }

        private function setButtonVisible(_arg_1:Boolean):void
        {
            var _local_2:IWindow = ((mainWindow) ? mainWindow.findChildByName("btn_craft") : null);
            if (_local_2)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function get mainWindow():IWindowContainer
        {
            return (_SafeStr_1324.window);
        }


    }
}

