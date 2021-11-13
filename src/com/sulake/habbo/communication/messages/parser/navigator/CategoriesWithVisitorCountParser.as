package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CategoriesWithVisitorCountParser implements IMessageParser 
    {

        private var _data:CategoriesWithVisitorCountData;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _data = new CategoriesWithVisitorCountData(_arg_1);
            return (true);
        }

        public function get data():CategoriesWithVisitorCountData
        {
            return (_data);
        }


    }
}