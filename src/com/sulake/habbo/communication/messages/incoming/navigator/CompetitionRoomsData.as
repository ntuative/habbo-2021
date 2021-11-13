package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CompetitionRoomsData 
    {

        private var _goalId:int;
        private var _pageIndex:int;
        private var _pageCount:int;

        public function CompetitionRoomsData(_arg_1:IMessageDataWrapper, _arg_2:int=0, _arg_3:int=0)
        {
            _goalId = _arg_2;
            _pageIndex = _arg_3;
            if (_arg_1 != null)
            {
                _goalId = _arg_1.readInteger();
                _pageIndex = _arg_1.readInteger();
                _pageCount = _arg_1.readInteger();
            };
        }

        public function get goalId():int
        {
            return (_goalId);
        }

        public function get pageIndex():int
        {
            return (_pageIndex);
        }

        public function get pageCount():int
        {
            return (_pageCount);
        }


    }
}