package com.sulake.habbo.communication.messages.parser.perk
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PerkAllowancesMessageParser implements IMessageParser 
    {

        private var _SafeStr_2071:Vector.<Perk>;


        public function flush():Boolean
        {
            _SafeStr_2071 = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_4:Perk;
            _SafeStr_2071 = new Vector.<Perk>();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _local_4 = new Perk();
                _local_4.code = _arg_1.readString();
                _local_4.errorMessage = _arg_1.readString();
                _local_4.isAllowed = _arg_1.readBoolean();
                _SafeStr_2071.push(_local_4);
                _local_3++;
            };
            return (true);
        }

        public function getPerks():Vector.<Perk>
        {
            return (_SafeStr_2071);
        }

        public function isPerkAllowed(_arg_1:String):Boolean
        {
            var _local_2:Perk = getPerk(_arg_1);
            return ((!(_local_2 == null)) && (_local_2.isAllowed));
        }

        public function getPerk(_arg_1:String):Perk
        {
            for each (var _local_2:Perk in _SafeStr_2071)
            {
                if (_local_2.code == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


    }
}

