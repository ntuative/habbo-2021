package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;

        public class SearchFaqsMessageComposer implements IMessageComposer 
    {

        private var _searchString:String;

        public function SearchFaqsMessageComposer(_arg_1:String)
        {
            _searchString = _arg_1;
        }

        public function getMessageArray():Array
        {
            return ([_searchString]);
        }

        public function dispose():void
        {
        }


    }
}