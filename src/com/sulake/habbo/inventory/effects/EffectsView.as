package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.IInventoryView;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.inventory.common.ThumbListManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;
    import flash.display.BitmapData;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class EffectsView implements IInventoryView
    {

        private var _windowManager:IHabboWindowManager;
        private var _SafeStr_1354:IAssetLibrary;
        private var _SafeStr_570:IWindowContainer;
        private var _SafeStr_1275:EffectsModel;
        private var _SafeStr_2743:ThumbListManager;
        private var _SafeStr_2744:ThumbListManager;
        private var _disposed:Boolean = false;

        public function EffectsView(_arg_1:EffectsModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IThumbListDataProvider, _arg_6:IThumbListDataProvider)
        {
            _SafeStr_1275 = _arg_1;
            _SafeStr_1354 = _arg_3;
            _windowManager = _arg_2;
            var _local_9:IAsset = _SafeStr_1354.getAssetByName("inventory_effects_xml");
            var _local_7:XmlAsset = XmlAsset(_local_9);
            _SafeStr_570 = IWindowContainer(_windowManager.buildFromXML(XML(_local_7.content)));
            _SafeStr_570.visible = false;
            _SafeStr_570.procedure = windowEventProc;
            _SafeStr_2743 = new ThumbListManager(_SafeStr_1354, _arg_5, "thumb_bg_png", "thumb_bg_selected_png", getActiveThumbListImageWidth(), getActiveThumbListImageHeight());
            _SafeStr_2744 = new ThumbListManager(_SafeStr_1354, _arg_6, "thumb_bg_png", "thumb_bg_selected_png", getActiveThumbListImageWidth(), getActiveThumbListImageHeight());
            var _local_10:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("active_items_image") as IBitmapWrapperWindow);
            _local_10.procedure = activeThumbListEventProc;
            var _local_8:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            _local_8.procedure = inactiveThumbListEventProc;
            _SafeStr_570.procedure = windowEventProc;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                _windowManager = null;
                _SafeStr_1275 = null;
                _SafeStr_570 = null;
                if (_SafeStr_2743 != null)
                {
                    _SafeStr_2743.dispose();
                    _SafeStr_2743 = null;
                };
                if (_SafeStr_2744 != null)
                {
                    _SafeStr_2744.dispose();
                    _SafeStr_2744 = null;
                };
                _disposed = true;
            };
        }

        public function getActiveThumbListImageWidth():int
        {
            var _local_1:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("active_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null)
            {
                return (0);
            };
            return (_local_1.width);
        }

        public function getActiveThumbListImageHeight():int
        {
            var _local_1:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("active_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null)
            {
                return (0);
            };
            return (_local_1.height);
        }

        public function getInactiveThumbListImageWidth():int
        {
            var _local_1:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null)
            {
                return (0);
            };
            return (_local_1.width);
        }

        public function getInactiveThumbListImageHeight():int
        {
            var _local_1:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            if (_local_1 == null)
            {
                return (0);
            };
            return (_local_1.height);
        }

        public function getWindowContainer():IWindowContainer
        {
            if (_SafeStr_570 == null)
            {
                return (null);
            };
            if (_SafeStr_570.disposed)
            {
                return (null);
            };
            return (_SafeStr_570);
        }

        public function updateListViews():void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (_SafeStr_570.disposed)
            {
                return;
            };
            _SafeStr_2744.updateImageFromList();
            _SafeStr_2743.updateImageFromList();
            var _local_2:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("inactive_items_image") as IBitmapWrapperWindow);
            var _local_4:BitmapData = _SafeStr_2744.getListImage();
            _local_2.bitmap = _local_4;
            _local_2.width = _local_4.width;
            _local_2.height = _local_4.height;
            _local_2.invalidate();
            var _local_3:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("active_items_image") as IBitmapWrapperWindow);
            var _local_1:BitmapData = _SafeStr_2743.getListImage();
            _local_3.bitmap = _local_1;
            _local_3.width = _local_1.width;
            _local_3.height = _local_1.height;
            _local_3.invalidate();
        }

        public function updateActionView():void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (_SafeStr_570.disposed)
            {
                return;
            };
            var _local_2:_SafeStr_101 = (_SafeStr_570.findChildByName("activateEffect_button") as _SafeStr_101);
            var _local_3:ITextWindow = (_SafeStr_570.findChildByName("effectDescriptionText") as ITextWindow);
            if (_local_2 == null)
            {
                return;
            };
            if (_local_3 == null)
            {
                return;
            };
            var _local_1:Effect = _SafeStr_1275.getSelectedEffect(-1);
            if (_local_1 == null)
            {
                _local_2.disable();
                setEffectDescriptionImage(null);
                _local_3.text = "${inventory.effects.defaultdescription}";
            }
            else
            {
                if (_local_1.isActive)
                {
                    _local_2.disable();
                    setEffectDescriptionImage(_local_1.iconImage);
                    _local_3.text = "${inventory.effects.active}";
                    _windowManager.registerLocalizationParameter("inventory.effects.active", "timeleft", convertSecondsToTime(_local_1.secondsLeft));
                    _windowManager.registerLocalizationParameter("inventory.effects.active", "duration", convertSecondsToTime(_local_1.duration));
                    _windowManager.registerLocalizationParameter("inventory.effects.active", "itemcount", String(_local_1.amountInInventory));
                }
                else
                {
                    _local_2.enable();
                    setEffectDescriptionImage(_local_1.iconImage);
                    _local_3.text = "${inventory.effects.inactive}";
                    _windowManager.registerLocalizationParameter("inventory.effects.inactive", "duration", convertSecondsToTime(_local_1.duration));
                    _windowManager.registerLocalizationParameter("inventory.effects.inactive", "itemcount", String(_local_1.amountInInventory));
                };
            };
        }

        private function setEffectDescriptionImage(_arg_1:BitmapData):void
        {
            if (_SafeStr_570 == null)
            {
                return;
            };
            if (_SafeStr_570.disposed)
            {
                return;
            };
            var _local_3:IBitmapWrapperWindow = (_SafeStr_570.findChildByName("effectDescriptionImage") as IBitmapWrapperWindow);
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.bitmap == null)
            {
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, false);
            };
            if (_arg_1 == null)
            {
                _arg_1 = new BitmapData(_local_3.width, _local_3.height);
            };
            var _local_2:Point = new Point(((_local_3.width - _arg_1.width) / 2), ((_local_3.height - _arg_1.height) / 2));
            _local_3.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_2, null, null, false);
            _local_3.invalidate();
        }

        private function convertSecondsToTime(_arg_1:int):String
        {
            var _local_2:int = int(Math.floor(((_arg_1 / 60) / 60)));
            var _local_4:int = int(Math.floor(((_arg_1 - ((_local_2 * 60) * 60)) / 60)));
            var _local_3:int = ((_arg_1 - ((_local_2 * 60) * 60)) - (_local_4 * 60));
            var _local_5:String = "";
            if (_local_2 > 0)
            {
                _local_5 = (_local_2 + ":");
            };
            _local_5 = ((_local_4 < 10) ? ((_local_5 + "0") + _local_4) : (_local_5 + _local_4));
            _local_5 = (_local_5 + ":");
            _local_5 = ((_local_3 < 10) ? ((_local_5 + "0") + _local_3) : (_local_5 + _local_3));
            return (_local_5);
        }

        private function activeThumbListEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Point;
            var _local_5:int;
            var _local_4:Effect;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = new Point(WindowMouseEvent(_arg_1).localX, WindowMouseEvent(_arg_1).localY);
                _local_5 = _SafeStr_2743.resolveIndexFromImageLocation(_local_3);
                _local_4 = _SafeStr_1275.getItemInIndex(_local_5, 1);
                if (_local_4 != null)
                {
                    _SafeStr_1275.toggleEffectSelected(_local_4.type);
                };
            };
        }

        private function inactiveThumbListEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Point;
            var _local_5:int;
            var _local_4:Effect;
            if (_arg_1.type == "WME_CLICK")
            {
                _local_3 = new Point(WindowMouseEvent(_arg_1).localX, WindowMouseEvent(_arg_1).localY);
                _local_5 = _SafeStr_2744.resolveIndexFromImageLocation(_local_3);
                _local_4 = _SafeStr_1275.getItemInIndex(_local_5, 0);
                if (_local_4 != null)
                {
                    _SafeStr_1275.toggleEffectSelected(_local_4.type);
                };
            };
        }

        private function windowEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:Effect;
            if (_arg_1.type == "WME_CLICK")
            {
                if (_arg_2.name == "activateEffect_button")
                {
                    _local_3 = _SafeStr_1275.getSelectedEffect(0);
                    if (_local_3 != null)
                    {
                        _SafeStr_1275.requestEffectActivated(_local_3.type);
                    };
                };
            };
        }


    }
}