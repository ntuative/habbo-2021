package com.sulake.habbo.moderation
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;

    public class IssueBundle 
    {

        private var _id:int;
        private var _SafeStr_2831:Map;
        private var _state:int;
        private var _pickerUserId:int = 0;
        private var _pickerName:String = "";
        private var _reportedUserId:int;
        private var _SafeStr_2832:int;
        private var _SafeStr_2833:int = 0;
        private var _issueAgeInMilliseconds:int = 0;
        private var _SafeStr_2834:IssueMessageData = null;
        private var _highestPriorityIssue:IssueMessageData = null;

        public function IssueBundle(_arg_1:int, _arg_2:IssueMessageData)
        {
            _id = _arg_1;
            _SafeStr_2831 = new Map();
            _state = _arg_2.state;
            _pickerUserId = _arg_2.pickerUserId;
            _pickerName = _arg_2.pickerUserName;
            _reportedUserId = _arg_2.reportedUserId;
            _SafeStr_2832 = _arg_2.groupingId;
            addIssue(_arg_2);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get issues():Array
        {
            return (_SafeStr_2831.getValues());
        }

        public function get state():int
        {
            return (_state);
        }

        public function get pickerUserId():int
        {
            return (_pickerUserId);
        }

        public function get pickerName():String
        {
            return (_pickerName);
        }

        public function matches(_arg_1:IssueMessageData, _arg_2:Boolean=false):Boolean
        {
            if (((_SafeStr_2832 == 0) || (_arg_1.groupingId == 0)))
            {
                return (false);
            };
            if (((!(_SafeStr_2832 == _arg_1.groupingId)) || (!(_reportedUserId == _arg_1.reportedUserId))))
            {
                return (false);
            };
            if (!_arg_2)
            {
                if (state != _arg_1.state)
                {
                    return (false);
                };
                if (pickerUserId != _arg_1.pickerUserId)
                {
                    return (false);
                };
            };
            return (true);
        }

        public function contains(_arg_1:int):Boolean
        {
            if (_SafeStr_2831 == null)
            {
                return (false);
            };
            return (_SafeStr_2831.getKeys().indexOf(_arg_1) > -1);
        }

        public function updateIssue(_arg_1:IssueMessageData):void
        {
            removeIssue(_arg_1.issueId);
            addIssue(_arg_1);
        }

        private function addIssue(_arg_1:IssueMessageData):void
        {
            _SafeStr_2831.add(_arg_1.issueId, _arg_1);
            _issueAgeInMilliseconds = _arg_1.issueAgeInMilliseconds;
            if (((!(_arg_1.message == null)) && (!(_arg_1.message == ""))))
            {
                _SafeStr_2833++;
            };
            if (((_SafeStr_2834 == null) || (_arg_1.issueAgeInMilliseconds > _SafeStr_2834.issueAgeInMilliseconds)))
            {
                _SafeStr_2834 = _arg_1;
            };
            _highestPriorityIssue = null;
            getHighestPriorityIssue();
        }

        public function removeIssue(_arg_1:int):IssueMessageData
        {
            var _local_2:IssueMessageData = (_SafeStr_2831.remove(_arg_1) as IssueMessageData);
            if (_local_2 != null)
            {
                if (((!(_local_2.message == null)) && (!(_local_2.message == ""))))
                {
                    _SafeStr_2833--;
                };
                if (_SafeStr_2834 == _local_2)
                {
                    _SafeStr_2834 = null;
                };
                if (_highestPriorityIssue == _local_2)
                {
                    _highestPriorityIssue = null;
                };
            };
            return (_local_2);
        }

        public function get highestPriority():int
        {
            if (_highestPriorityIssue == null)
            {
                getHighestPriorityIssue();
            };
            if (_highestPriorityIssue != null)
            {
                return (_highestPriorityIssue.priority);
            };
            return (0);
        }

        public function getHighestPriorityIssue():IssueMessageData
        {
            var _local_3:IssueMessageData = null;
            var _local_4:IssueMessageData = null;
            var _local_2:int;
            var _local_1:IssueMessageData;
            var _local_5:Boolean;
            if (_highestPriorityIssue == null)
            {
                if (((_SafeStr_2831 == null) || (_SafeStr_2831.length < 1)))
                {
                    return (null);
                };
                _local_2 = 0;
                while (_local_2 < _SafeStr_2831.length)
                {
                    _local_1 = _SafeStr_2831.getWithIndex(_local_2);
                    _local_5 = ((_local_1.reportedCategoryId > 0) && (_local_1.reportedCategoryId < 100));
                    if (_local_5)
                    {
                        if (((_local_4 == null) || (_local_4.priority > _local_1.priority)))
                        {
                            _local_4 = _local_1;
                        };
                    }
                    else
                    {
                        if (((_local_3 == null) || (_local_3.priority > _local_1.priority)))
                        {
                            _local_3 = _local_1;
                        };
                    };
                    _local_2++;
                };
                if (_local_4 != null)
                {
                    _highestPriorityIssue = _local_4;
                }
                else
                {
                    _highestPriorityIssue = _local_3;
                };
            };
            return (_highestPriorityIssue);
        }

        public function getIssueCount():int
        {
            if (_SafeStr_2831 == null)
            {
                return (0);
            };
            return (_SafeStr_2831.length);
        }

        public function getIssueIds():Array
        {
            if (_SafeStr_2831 == null)
            {
                return ([]);
            };
            return (_SafeStr_2831.getKeys());
        }

        public function get reportedUserId():int
        {
            return (_reportedUserId);
        }

        public function getMessageCount():int
        {
            return (_SafeStr_2833);
        }

        public function get issueAgeInMilliseconds():int
        {
            return (_issueAgeInMilliseconds);
        }

        public function getOpenTime(_arg_1:int):String
        {
            var _local_2:IssueMessageData;
            var _local_3:IssueMessageData = _SafeStr_2834;
            if (_local_3 == null)
            {
                for each (_local_2 in _SafeStr_2831)
                {
                    if (((_local_3 == null) || (_local_2.issueAgeInMilliseconds > _local_3.issueAgeInMilliseconds)))
                    {
                        _local_3 = _local_2;
                    };
                };
                _SafeStr_2834 = _local_3;
            };
            if (_local_3 != null)
            {
                return (_local_3.getOpenTime(_arg_1));
            };
            return ("");
        }


    }
}

