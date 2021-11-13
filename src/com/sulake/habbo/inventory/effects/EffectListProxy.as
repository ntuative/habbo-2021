package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.inventory.common.IThumbListDataProvider;

    public class EffectListProxy implements IThumbListDataProvider 
    {

        private var _SafeStr_1275:EffectsModel;
        private var _SafeStr_2719:int;

        public function EffectListProxy(_arg_1:EffectsModel, _arg_2:int)
        {
            _SafeStr_1275 = _arg_1;
            _SafeStr_2719 = _arg_2;
        }

        public function dispose():void
        {
            _SafeStr_1275 = null;
        }

        public function getDrawableList():Array
        {
            return (_SafeStr_1275.getEffects(_SafeStr_2719));
        }


    }
}

