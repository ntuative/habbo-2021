package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TopLevelContext 
    {

        private var _searchCode:String;
        private var _quickLinks:Vector.<SavedSearch> = new Vector.<SavedSearch>(0);

        public function TopLevelContext(_arg_1:IMessageDataWrapper)
        {
            var _local_3:int;
            super();
            _searchCode = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                quickLinks.push(new SavedSearch(_arg_1));
                _local_3++;
            };
        }

        public function get searchCode():String
        {
            return (_searchCode);
        }

        public function get quickLinks():Vector.<SavedSearch>
        {
            return (_quickLinks);
        }


    }
}