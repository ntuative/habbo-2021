package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SavedSearch;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NavigatorSavedSearchesParser implements IMessageParser 
    {

        private var _savedSearches:Vector.<SavedSearch>;


        public function flush():Boolean
        {
            _savedSearches = new Vector.<SavedSearch>(0);
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _savedSearches.push(new SavedSearch(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get savedSearches():Vector.<SavedSearch>
        {
            return (_savedSearches);
        }


    }
}