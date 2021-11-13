package com.sulake.habbo.avatar.structure.parts
{
    public class PartDefinition 
    {

        private var _setType:String;
        private var _flippedSetType:String;
        private var _removeSetType:String;
        private var _appendToFigure:Boolean;
        private var _staticId:int = -1;

        public function PartDefinition(_arg_1:XML)
        {
            _setType = String(_arg_1.@["set-type"]);
            _flippedSetType = String(_arg_1.@["flipped-set-type"]);
            _removeSetType = String(_arg_1.@["remove-set-type"]);
            _appendToFigure = false;
        }

        public function hasStaticId():Boolean
        {
            return (_staticId >= 0);
        }

        public function get staticId():int
        {
            return (_staticId);
        }

        public function set staticId(_arg_1:int):void
        {
            _staticId = _arg_1;
        }

        public function get setType():String
        {
            return (_setType);
        }

        public function get flippedSetType():String
        {
            return (_flippedSetType);
        }

        public function get removeSetType():String
        {
            return (_removeSetType);
        }

        public function get appendToFigure():Boolean
        {
            return (_appendToFigure);
        }

        public function set appendToFigure(_arg_1:Boolean):void
        {
            _appendToFigure = _arg_1;
        }

        public function set flippedSetType(_arg_1:String):void
        {
            _flippedSetType = _arg_1;
        }


    }
}