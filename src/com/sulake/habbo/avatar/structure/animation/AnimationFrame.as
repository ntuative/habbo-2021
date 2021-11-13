package com.sulake.habbo.avatar.structure.animation
{
    public class AnimationFrame 
    {

        private var _number:int;
        private var _assetPartDefinition:String;

        public function AnimationFrame(_arg_1:XML)
        {
            _number = parseInt(_arg_1.@number);
            _assetPartDefinition = _arg_1.@assetpartdefinition;
        }

        public function get number():int
        {
            return (_number);
        }

        public function get assetPartDefinition():String
        {
            return (_assetPartDefinition);
        }


    }
}