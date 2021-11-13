package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.newnavigator.SearchResultSet;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NavigatorSearchResultBlocksParser implements IMessageParser 
    {

        private var _searchResult:SearchResultSet;


        public function flush():Boolean
        {
            _searchResult = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _searchResult = new SearchResultSet(_arg_1);
            return (true);
        }

        public function get searchResult():SearchResultSet
        {
            return (_searchResult);
        }


    }
}