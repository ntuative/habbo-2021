package com.sulake.habbo.avatar.alias
{
    public class AssetAlias
    {

        private var _name:String;
        private var _link:String;
        private var _flipH:Boolean;
        private var _flipV:Boolean;

        public function AssetAlias(_arg_1:XML)
        {
            _name = String(_arg_1.@name);
            _link = String(_arg_1.@link);
            _flipH = !!parseInt(_arg_1.@fliph);
            _flipV = !!parseInt(_arg_1.@flipv);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get link():String
        {
            return (_link);
        }

        public function get flipH():Boolean
        {
            return (_flipH);
        }

        public function get flipV():Boolean
        {
            return (_flipV);
        }


    }
}
