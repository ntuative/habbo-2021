package com.sulake.habbo.avatar.common
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.core.window.IWindow;

    public class CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        protected var _SafeStr_575:Map;
        protected var _SafeStr_1284:HabboAvatarEditor;
        protected var _SafeStr_573:Boolean = false;
        protected var _SafeStr_570:IAvatarEditorCategoryView;
        private var _disposed:Boolean;

        public function CategoryBaseModel(_arg_1:HabboAvatarEditor)
        {
            _SafeStr_1284 = _arg_1;
        }

        public function dispose():void
        {
            if (_SafeStr_570 != null)
            {
                _SafeStr_570.dispose();
            };
            _SafeStr_570 = null;
            _SafeStr_575 = null;
            _SafeStr_1284 = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        protected function init():void
        {
            if (!_SafeStr_575)
            {
                _SafeStr_575 = new Map();
            };
        }

        public function reset():void
        {
            _SafeStr_573 = false;
            for each (var _local_1:CategoryData in _SafeStr_575)
            {
                if (_local_1)
                {
                    _local_1.dispose();
                };
            };
            _SafeStr_575 = new Map();
            if (_SafeStr_570)
            {
                _SafeStr_570.reset();
            };
        }

        protected function initCategory(_arg_1:String):void
        {
            var _local_3:CategoryData;
            var _local_2:CategoryData = _SafeStr_575[_arg_1];
            if (_local_2 == null)
            {
                _local_3 = _SafeStr_1284.generateDataContent(this, _arg_1);
                if (_local_3)
                {
                    _SafeStr_575[_arg_1] = _local_3;
                    updateSelectionsFromFigure(_arg_1);
                };
            };
        }

        public function switchCategory(_arg_1:String=""):void
        {
            if (!_SafeStr_573)
            {
                init();
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.switchCategory(_arg_1);
            };
        }

        protected function updateSelectionsFromFigure(_arg_1:String):void
        {
            if ((((!(_SafeStr_575)) || (!(_SafeStr_1284))) || (!(_SafeStr_1284.figureData))))
            {
                return;
            };
            var _local_2:CategoryData = _SafeStr_575[_arg_1];
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:int = _SafeStr_1284.figureData.getPartSetId(_arg_1);
            var _local_3:Array = _SafeStr_1284.figureData.getColourIds(_arg_1);
            if (!_local_3)
            {
                _local_3 = [];
            };
            _local_2.selectPartId(_local_4);
            _local_2.selectColorIds(_local_3);
            if (_SafeStr_570)
            {
                _SafeStr_570.showPalettes(_arg_1, _local_3.length);
            };
        }

        public function hasClubItemsOverLevel(_arg_1:int):Boolean
        {
            var _local_2:Boolean;
            if (!_SafeStr_575)
            {
                return (false);
            };
            for each (var _local_3:CategoryData in _SafeStr_575.getValues())
            {
                if (_local_3 != null)
                {
                    _local_2 = _local_3.hasClubSelectionsOverLevel(_arg_1);
                    if (_local_2)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function hasInvalidSellableItems(_arg_1:IHabboInventory):Boolean
        {
            var _local_2:Boolean;
            if (!_SafeStr_575)
            {
                return (false);
            };
            for each (var _local_3:CategoryData in _SafeStr_575.getValues())
            {
                if (_local_3 != null)
                {
                    _local_2 = _local_3.hasInvalidSellableItems(_arg_1);
                    if (_local_2)
                    {
                        return (true);
                    };
                };
            };
            return (false);
        }

        public function stripClubItemsOverLevel(_arg_1:int):Boolean
        {
            var _local_6:int;
            var _local_2:String;
            var _local_7:CategoryData;
            var _local_5:Boolean;
            var _local_3:AvatarEditorGridPartItem;
            if (!_SafeStr_575)
            {
                return (false);
            };
            var _local_8:Array = _SafeStr_575.getKeys();
            var _local_4:Boolean;
            _local_6 = 0;
            while (_local_6 < _local_8.length)
            {
                _local_2 = _local_8[_local_6];
                _local_7 = _SafeStr_575[_local_2];
                _local_5 = false;
                if (_local_7.stripClubItemsOverLevel(_arg_1))
                {
                    _local_5 = true;
                };
                if (_local_7.stripClubColorsOverLevel(_arg_1))
                {
                    _local_5 = true;
                };
                if (_local_5)
                {
                    _local_3 = _local_7.getCurrentPart();
                    if (((((_local_3) && (_SafeStr_1284)) && (_SafeStr_1284.figureData)) && (_local_7)))
                    {
                        _SafeStr_1284.figureData.savePartData(_local_2, _local_3.id, _local_7.getSelectedColorIds(), true);
                    };
                    _local_4 = true;
                };
                _local_6++;
            };
            return (_local_4);
        }

        public function stripInvalidSellableItems():Boolean
        {
            var _local_5:int;
            var _local_1:String;
            var _local_6:CategoryData;
            var _local_4:Boolean;
            var _local_2:AvatarEditorGridPartItem;
            if (!_SafeStr_575)
            {
                return (false);
            };
            var _local_7:Array = _SafeStr_575.getKeys();
            var _local_3:Boolean;
            _local_5 = 0;
            while (_local_5 < _local_7.length)
            {
                _local_1 = _local_7[_local_5];
                _local_6 = _SafeStr_575[_local_1];
                _local_4 = false;
                if (_local_6.stripInvalidSellableItems(_SafeStr_1284.manager.inventory))
                {
                    _local_4 = true;
                };
                if (_local_4)
                {
                    _local_2 = _local_6.getCurrentPart();
                    if (((((_local_2) && (_SafeStr_1284)) && (_SafeStr_1284.figureData)) && (_local_6)))
                    {
                        _SafeStr_1284.figureData.savePartData(_local_1, _local_2.id, _local_6.getSelectedColorIds(), true);
                    };
                    _local_3 = true;
                };
                _local_5++;
            };
            return (_local_3);
        }

        public function selectPart(_arg_1:String, _arg_2:int):void
        {
            var _local_3:CategoryData = _SafeStr_575[_arg_1];
            if (_local_3 == null)
            {
                return;
            };
            var _local_5:int = _local_3.selectedPartIndex;
            _local_3.selectPartIndex(_arg_2);
            var _local_4:AvatarEditorGridPartItem = _local_3.getCurrentPart();
            if (!_local_4)
            {
                return;
            };
            if (_local_4.isDisabledForWearing)
            {
                _local_3.selectPartIndex(_local_5);
                _SafeStr_1284.openHabboClubAdWindow();
                return;
            };
            if (_SafeStr_570)
            {
                _SafeStr_570.showPalettes(_arg_1, _local_4.colorLayerCount);
            };
            if (((_SafeStr_1284) && (_SafeStr_1284.figureData)))
            {
                _SafeStr_1284.figureData.savePartData(_arg_1, _local_4.id, _local_3.getSelectedColorIds(), true);
            };
        }

        public function selectColor(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            var _local_6:AvatarEditorGridColorItem;
            var _local_5:CategoryData = _SafeStr_575[_arg_1];
            if (_local_5 == null)
            {
                return;
            };
            var _local_4:int = _local_5.getCurrentColorIndex(_arg_3);
            _local_5.selectColorIndex(_arg_2, _arg_3);
            if (((_SafeStr_1284) && (_SafeStr_1284.figureData)))
            {
                _local_6 = _local_5.getSelectedColor(_arg_3);
                if (_local_6.isDisabledForWearing)
                {
                    _local_5.selectColorIndex(_local_4, _arg_3);
                    _SafeStr_1284.openHabboClubAdWindow();
                    return;
                };
                _SafeStr_1284.figureData.savePartSetColourId(_arg_1, _local_5.getSelectedColorIds(), true);
            };
        }

        public function get controller():HabboAvatarEditor
        {
            return (_SafeStr_1284);
        }

        public function getWindowContainer():IWindow
        {
            if (!_SafeStr_573)
            {
                init();
            };
            if (!_SafeStr_570)
            {
                return (null);
            };
            return (_SafeStr_570.getWindowContainer());
        }

        public function getCategoryData(_arg_1:String):CategoryData
        {
            if (!_SafeStr_573)
            {
                init();
            };
            if (!_SafeStr_575)
            {
                return (null);
            };
            return (_SafeStr_575[_arg_1]);
        }


    }
}

