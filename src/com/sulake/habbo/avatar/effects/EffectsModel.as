package com.sulake.habbo.avatar.effects
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.avatar.IHabboAvatarEditorAvatarEffect;
    import com.sulake.habbo.inventory.IAvatarEffect;

    public class EffectsModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public static const GRIDTYPE_EFFECTS:String = "effects";

        private var _SafeStr_1290:Dictionary = new Dictionary();
        private var _SafeStr_1291:EffectsParamView;

        public function EffectsModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }

        override protected function init():void
        {
            super.init();
            _SafeStr_573 = true;
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new EffectsView(this);
                _SafeStr_1291 = new EffectsParamView(this, controller.manager.windowManager, controller.manager.assets);
                if (_SafeStr_570)
                {
                    _SafeStr_570.init();
                };
            };
        }

        public function get effects():Array
        {
            if (controller.manager.inventory == null)
            {
                return ([]);
            };
            return (controller.manager.inventory.getAvatarEffects());
        }

        override public function selectPart(_arg_1:String, _arg_2:int):void
        {
            var _local_3:IHabboAvatarEditorAvatarEffect;
            setSelectionVisual(_arg_1, _SafeStr_1290[_arg_1], false);
            var _local_5:int = controller.figureData.avatarEffectType;
            if (((_arg_2 == -1) && (!(_local_5 == -1))))
            {
                _arg_2 = EffectsView(_SafeStr_570).getGridIndex(_local_5);
                for each (var _local_4:IAvatarEffect in effects)
                {
                    if (_local_4.type == _local_5)
                    {
                        _local_3 = IHabboAvatarEditorAvatarEffect(_local_4);
                        _local_3.isSelected = true;
                        break;
                    };
                };
            }
            else
            {
                if ((((_arg_2 == -1) && (_local_5 == -1)) || (_arg_2 == 0)))
                {
                    _arg_2 = 0;
                    controller.setAvatarEffectType(-1);
                    _SafeStr_1291.updateView(null);
                }
                else
                {
                    _local_3 = IHabboAvatarEditorAvatarEffect(effects[(_arg_2 - 1)]);
                    _local_3.isSelected = true;
                    controller.setAvatarEffectType(_local_3.type);
                };
            };
            _SafeStr_1290[_arg_1] = _arg_2;
            setSelectionVisual(_arg_1, _arg_2, true);
            _SafeStr_1291.updateView(_local_3);
        }

        private function setSelectionVisual(_arg_1:String, _arg_2:int, _arg_3:Boolean):void
        {
            EffectsView(_SafeStr_570).updateSelectionVisual(_arg_1, _arg_2, _arg_3);
        }


    }
}

