package com.sulake.habbo.avatar.generic
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.common.CategoryData;
    import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;

    public class BodyModel extends CategoryBaseModel implements IAvatarEditorCategoryModel, IAvatarImageListener 
    {

        public function BodyModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }

        override protected function init():void
        {
            super.init();
            initCategory("hd");
            _SafeStr_573 = true;
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new BodyView(this);
                if (_SafeStr_570)
                {
                    _SafeStr_570.init();
                };
            };
        }

        override public function switchCategory(_arg_1:String=""):void
        {
            _SafeStr_570.switchCategory(_arg_1);
        }

        override public function selectColor(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_4:CategoryData = _SafeStr_575[_arg_1];
            if (_local_4 == null)
            {
                return;
            };
            _local_4.selectColorIndex(_arg_2, _arg_3);
            var _local_5:AvatarEditorGridColorItem = _local_4.getSelectedColor(_arg_3);
            if (_local_5.isDisabledForWearing)
            {
                _SafeStr_1284.openHabboClubAdWindow();
                return;
            };
            _SafeStr_1284.figureData.savePartSetColourId(_arg_1, _local_4.getSelectedColorIds(), true);
            updateSelectionsFromFigure("hd");
        }

        override protected function updateSelectionsFromFigure(_arg_1:String):void
        {
            var _local_2:CategoryData = getFaceCategoryData();
            if (!_local_2)
            {
                return;
            };
            updateIconImage(_local_2);
        }

        private function getFaceCategoryData():CategoryData
        {
            if (!_SafeStr_575)
            {
                return (null);
            };
            var _local_1:CategoryData = _SafeStr_575["hd"];
            if (_local_1 == null)
            {
                return (null);
            };
            var _local_3:int = _SafeStr_1284.figureData.getPartSetId("hd");
            var _local_2:Array = _SafeStr_1284.figureData.getColourIds("hd");
            _local_1.selectPartId(_local_3);
            _local_1.selectColorIds(_local_2);
            return (_local_1);
        }

        private function updateIconImage(_arg_1:CategoryData, _arg_2:String=null):void
        {
            var _local_5:String;
            var _local_4:IAvatarImage;
            for each (var _local_3:AvatarEditorGridPartItem in _arg_1.parts)
            {
                if (_local_3.partSet)
                {
                    _local_5 = _SafeStr_1284.figureData.getFigureStringWithFace(_local_3.id);
                    if (((_arg_2 == null) || (_arg_2 == _local_5)))
                    {
                        _local_4 = _SafeStr_1284.manager.avatarRenderManager.createAvatarImage(_local_5, "h", null, this);
                        _local_3.iconImage = _local_4.getCroppedImage("head");
                        _local_4.dispose();
                    };
                };
            };
        }

        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:CategoryData = getFaceCategoryData();
            if (!_local_2)
            {
                return;
            };
            updateIconImage(_local_2, _arg_1);
        }


    }
}

