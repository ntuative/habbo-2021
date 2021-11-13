package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;

    public class AvatarEditorGridColorItem 
    {

        private static const SELECTED_ASSET:String = "avatar_editor_editor_clr_13x21_3";
        private static const UNSELECTED_ASSET:String = "avatar_editor_editor_clr_13x21_1";
        private static const COLORIZATION_ASSET:String = "avatar_editor_editor_clr_13x21_2";

        private var _SafeStr_1275:IAvatarEditorCategoryModel;
        private var _view:IWindowContainer;
        private var _partColor:IPartColor;
        private var _isSelected:Boolean = false;
        private var _SafeStr_1276:IStaticBitmapWrapperWindow;
        private var _isDisabledForWearing:Boolean;

        public function AvatarEditorGridColorItem(_arg_1:IWindowContainer, _arg_2:IAvatarEditorCategoryModel, _arg_3:IPartColor, _arg_4:Boolean=false)
        {
            _SafeStr_1275 = _arg_2;
            _view = _arg_1;
            _partColor = _arg_3;
            _isDisabledForWearing = _arg_4;
            _SafeStr_1276 = (_view.findChildByTag("BORDER") as IStaticBitmapWrapperWindow);
            setupColor();
            updateThumbData();
            _view.addEventListener("WME_OVER", onMouseOver);
            _view.addEventListener("WME_OUT", onMouseOut);
        }

        private function onMouseOut(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1276.assetUri = ((_isSelected) ? "avatar_editor_editor_clr_13x21_3" : "avatar_editor_editor_clr_13x21_1");
        }

        private function onMouseOver(_arg_1:WindowMouseEvent):void
        {
            _SafeStr_1276.assetUri = "avatar_editor_editor_clr_13x21_3";
        }

        private function setupColor():void
        {
            var _local_1:BitmapDataAsset = (_SafeStr_1275.controller.manager.windowManager.assets.getAssetByName("avatar_editor_editor_clr_13x21_2") as BitmapDataAsset);
            var _local_2:BitmapData = (_local_1.content as BitmapData);
            var _local_3:BitmapData = _local_2.clone();
            var _local_4:IBitmapWrapperWindow = (_view.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
            _local_4.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
            _local_3.colorTransform(_local_3.rect, _partColor.colorTransform);
            _local_4.bitmap.copyPixels(_local_3, _local_3.rect, new Point(0, 0));
            _local_3.dispose();
        }

        public function dispose():void
        {
            _SafeStr_1275 = null;
            if (_view != null)
            {
                if (!_view.disposed)
                {
                    _view.dispose();
                };
            };
            _view = null;
            _partColor = null;
        }

        public function get view():IWindowContainer
        {
            return (_view);
        }

        public function get isSelected():Boolean
        {
            return (_isSelected);
        }

        public function set isSelected(_arg_1:Boolean):void
        {
            _isSelected = _arg_1;
            _SafeStr_1276.assetUri = ((_isSelected) ? "avatar_editor_editor_clr_13x21_3" : "avatar_editor_editor_clr_13x21_1");
        }

        private function updateThumbData():void
        {
            if (_view == null)
            {
                return;
            };
            if (_view.disposed)
            {
                return;
            };
            _SafeStr_1276.assetUri = "avatar_editor_editor_clr_13x21_3";
            var _local_1:IWindow = _view.findChildByTag("CLUB_ICON");
            if (_partColor)
            {
                _local_1.visible = (_partColor.clubLevel > 0);
            }
            else
            {
                _local_1.visible = false;
            };
        }

        public function get partColor():IPartColor
        {
            return (_partColor);
        }

        public function get isDisabledForWearing():Boolean
        {
            return (_isDisabledForWearing);
        }


    }
}

