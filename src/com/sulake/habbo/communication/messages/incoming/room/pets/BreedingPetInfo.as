package com.sulake.habbo.communication.messages.incoming.room.pets
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class BreedingPetInfo 
    {

        private var _webId:int;
        private var _name:String;
        private var _level:int;
        private var _figure:String;
        private var _owner:String;

        public function BreedingPetInfo(_arg_1:IMessageDataWrapper)
        {
            _webId = _arg_1.readInteger();
            _name = _arg_1.readString();
            _level = _arg_1.readInteger();
            _figure = _arg_1.readString();
            _owner = _arg_1.readString();
        }

        public function dispose():void
        {
            _webId = 0;
            _name = "";
            _level = 0;
            _figure = "";
            _owner = "";
        }

        public function get webId():int
        {
            return (_webId);
        }

        public function get name():String
        {
            return (_name);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get figure():String
        {
            return (_figure);
        }

        public function get owner():String
        {
            return (_owner);
        }


    }
}