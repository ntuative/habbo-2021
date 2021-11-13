package com.sulake.habbo.communication.messages.parser.room.pets
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PetCommandsMessageParser implements IMessageParser 
    {

        private var _petId:int;
        private var _allCommands:Array;
        private var _enabledCommands:Array;


        public function get petId():int
        {
            return (_petId);
        }

        public function get allCommands():Array
        {
            return (_allCommands);
        }

        public function get enabledCommands():Array
        {
            return (_enabledCommands);
        }

        public function flush():Boolean
        {
            _petId = -1;
            _allCommands = null;
            _enabledCommands = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            _petId = _arg_1.readInteger();
            var _local_3:int = _arg_1.readInteger();
            _allCommands = [];
            while (_local_3-- > 0)
            {
                _allCommands.push(_arg_1.readInteger());
            };
            var _local_2:int = _arg_1.readInteger();
            _enabledCommands = [];
            while (_local_2-- > 0)
            {
                _enabledCommands.push(_arg_1.readInteger());
            };
            return (true);
        }


    }
}