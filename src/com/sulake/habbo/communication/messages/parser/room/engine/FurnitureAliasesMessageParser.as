package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FurnitureAliasesMessageParser implements IMessageParser 
    {

        private var _aliases:Map = null;

        public function FurnitureAliasesMessageParser()
        {
            _aliases = new Map();
        }

        public function get aliasCount():int
        {
            return (_aliases.length);
        }

        public function getName(_arg_1:int):String
        {
            if (((_arg_1 < 0) || (_arg_1 >= aliasCount)))
            {
                return (null);
            };
            return (_aliases.getKey(_arg_1));
        }

        public function getAlias(_arg_1:int):String
        {
            if (((_arg_1 < 0) || (_arg_1 >= aliasCount)))
            {
                return (null);
            };
            return (_aliases.getWithIndex(_arg_1));
        }

        public function flush():Boolean
        {
            _aliases.reset();
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_4:int;
            var _local_2:String;
            var _local_5:String;
            _aliases.reset();
            var _local_3:int = _arg_1.readInteger();
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_2 = _arg_1.readString();
                _local_5 = _arg_1.readString();
                _aliases.remove(_local_2);
                _aliases.add(_local_2, _local_5);
                _local_4++;
            };
            return (true);
        }


    }
}