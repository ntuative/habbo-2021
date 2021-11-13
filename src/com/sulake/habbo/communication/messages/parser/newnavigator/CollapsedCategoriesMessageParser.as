package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CollapsedCategoriesMessageParser implements IMessageParser 
    {

        private var _collapsedCategories:Vector.<String>;


        public function flush():Boolean
        {
            _collapsedCategories = new Vector.<String>(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _collapsedCategories.push(_arg_1.readString());
                _local_3++;
            };
            return (true);
        }

        public function get collapsedCategories():Vector.<String>
        {
            return (_collapsedCategories);
        }


    }
}