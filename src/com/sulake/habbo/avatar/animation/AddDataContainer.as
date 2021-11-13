package com.sulake.habbo.avatar.animation
{
    public class AddDataContainer
    {

        private var _id:String;
        private var _align:String;
        private var _base:String;
        private var _ink:String;
        private var _blend:Number = 1;

        public function AddDataContainer(_arg_1:XML)
        {
            _id = String(_arg_1.@id);
            _align = String(_arg_1.@align);
            _base = String(_arg_1.@base);
            _ink = String(_arg_1.@ink);
            var _local_2:String = String(_arg_1.@blend);
            if (_local_2.length > 0)
            {
                _blend = Number(_local_2);
                if (_blend > 1)
                {
                    _blend = (_blend / 100);
                };
            };
        }

        public function get id():String
        {
            return (_id);
        }

        public function get align():String
        {
            return (_align);
        }

        public function get base():String
        {
            return (_base);
        }

        public function get ink():String
        {
            return (_ink);
        }

        public function get blend():Number
        {
            return (_blend);
        }

        public function get isBlended():Boolean
        {
            return (!(_blend == 1));
        }


    }
}
