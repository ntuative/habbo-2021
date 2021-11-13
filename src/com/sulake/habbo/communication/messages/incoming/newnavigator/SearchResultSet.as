package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;

        public class SearchResultSet 
    {

        private var _searchCodeOriginal:String;
        private var _filteringData:String;
        private var _blocks:Vector.<SearchResultList> = new Vector.<SearchResultList>(0);

        public function SearchResultSet(_arg_1:IMessageDataWrapper, _arg_2:SearchResultList=null)
        {
            var _local_3:int;
            var _local_4:int;
            super();
            if (_arg_2 != null)
            {
                _searchCodeOriginal = _arg_2.searchCode;
                _filteringData = _arg_2.text;
                _blocks.push(_arg_2);
            }
            else
            {
                _searchCodeOriginal = _arg_1.readString();
                _filteringData = _arg_1.readString();
                _local_3 = _arg_1.readInteger();
                _local_4 = 0;
                while (_local_4 < _local_3)
                {
                    _blocks.push(new SearchResultList(_arg_1));
                    _local_4++;
                };
            };
        }

        public function get searchCodeOriginal():String
        {
            return (_searchCodeOriginal);
        }

        public function get filteringData():String
        {
            return (_filteringData);
        }

        public function get blocks():Vector.<SearchResultList>
        {
            return (_blocks);
        }

        public function findGuestRoom(_arg_1:int):GuestRoomData
        {
            var _local_3:GuestRoomData;
            for each (var _local_2:SearchResultList in _blocks)
            {
                _local_3 = _local_2.findGuestRoom(_arg_1);
                if (_local_3 != null)
                {
                    return (_local_3);
                };
            };
            return (null);
        }


    }
}