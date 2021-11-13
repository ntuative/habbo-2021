package com.sulake.habbo.avatar.effects
{
    import com.sulake.habbo.avatar.common.CategoryBaseView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryView;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.core.window.IWindowContainer;

    public class EffectsView extends CategoryBaseView implements IAvatarEditorCategoryView 
    {

        public function EffectsView(_arg_1:IAvatarEditorCategoryModel)
        {
            super(_arg_1);
        }

        override public function init():void
        {
            if (!_window)
            {
                _window = (_SafeStr_1275.controller.view.getCategoryContainer("effects") as IWindowContainer);
                _window.visible = false;
            };
            if (((_SafeStr_1275) && (_SafeStr_1285 == "")))
            {
                _SafeStr_1275.switchCategory("effects");
            };
            _SafeStr_573 = true;
            updateGridView(_SafeStr_1285);
        }

        override public function reset():void
        {
            updateGridView(_SafeStr_1285);
            _SafeStr_1275.selectPart(_SafeStr_1285, -1);
        }

        public function switchCategory(_arg_1:String):void
        {
            if (_window == null)
            {
                return;
            };
            if (_window.disposed)
            {
                return;
            };
            _arg_1 = ((_arg_1 == "") ? _SafeStr_1285 : _arg_1);
            _SafeStr_1285 = _arg_1;
            if (!_SafeStr_573)
            {
                init();
            };
            updateGridView(_SafeStr_1285);
        }

        public function updateSelectionVisual(_arg_1:String, _arg_2:int, _arg_3:Boolean):void
        {
            AvatarEditorGridViewEffects(_SafeStr_1275.controller.view.effectsGridView).updateSelection(_arg_2, _arg_3);
        }

        public function getGridIndex(_arg_1:int):int
        {
            return (AvatarEditorGridViewEffects(_SafeStr_1275.controller.view.effectsGridView).getGridIndex(_arg_1));
        }

        override protected function updateGridView(_arg_1:String):void
        {
            _SafeStr_1275.controller.view.effectsGridView.initFromList(_SafeStr_1275, _arg_1);
        }


    }
}

