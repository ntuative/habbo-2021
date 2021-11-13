package com.sulake.habbo.communication.messages.incoming.newnavigator
{
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;

        public class SearchResultContainer 
    {

        private var _searchCodeOriginal:String;
        private var _filteringData:String;
        private var _resultSet:SearchResultSet;

        public function SearchResultContainer(_arg_1:SearchResultSet)
        {
            _searchCodeOriginal = _arg_1.searchCodeOriginal;
            _filteringData = _arg_1.filteringData;
            _resultSet = _arg_1;
        }

        public function get searchCodeOriginal():String
        {
            return (_searchCodeOriginal);
        }

        public function get filteringData():String
        {
            return (_filteringData);
        }

        public function get resultSet():SearchResultSet
        {
            return (_resultSet);
        }

        public function findGuestRoom(_arg_1:int):GuestRoomData
        {
            if (_resultSet != null)
            {
                return (_resultSet.findGuestRoom(_arg_1));
            };
            return (null);
        }


    }
}