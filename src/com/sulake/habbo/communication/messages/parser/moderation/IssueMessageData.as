package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.getTimer;

        public class IssueMessageData implements IDisposable 
    {

        public static const STATE_OPEN:int = 1;
        public static const _SafeStr_2066:int = 2;
        public static const _SafeStr_2067:int = 3;

        private var _issueId:int;
        private var _state:int;
        private var _categoryId:int;
        private var _reportedCategoryId:int;
        private var _issueAgeInMilliseconds:Number;
        private var _priority:int;
        private var _groupingId:int;
        private var _reporterUserId:int;
        private var _reporterUserName:String;
        private var _reportedUserId:int;
        private var _reportedUserName:String;
        private var _pickerUserId:int;
        private var _pickerUserName:String;
        private var _message:String;
        private var _chatRecordId:int;
        private var _patterns:Array;
        private var _disposed:Boolean = false;
        private var _SafeStr_2068:Number;

        public function IssueMessageData(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:String, _arg_10:int, _arg_11:String, _arg_12:int, _arg_13:String, _arg_14:String, _arg_15:int, _arg_16:Array)
        {
            _issueId = _arg_1;
            _state = _arg_2;
            _categoryId = _arg_3;
            _reportedCategoryId = _arg_4;
            _issueAgeInMilliseconds = _arg_5;
            _priority = _arg_6;
            _groupingId = _arg_7;
            _reporterUserId = _arg_8;
            _reporterUserName = _arg_9;
            _reportedUserId = _arg_10;
            _reportedUserName = _arg_11;
            _pickerUserId = _arg_12;
            _pickerUserName = _arg_13;
            _message = _arg_14;
            _chatRecordId = _arg_15;
            _patterns = _arg_16;
            _SafeStr_2068 = getTimer();
        }

        public function get issueId():int
        {
            return (_issueId);
        }

        public function get state():int
        {
            return (_state);
        }

        public function get categoryId():int
        {
            return (_categoryId);
        }

        public function get reportedCategoryId():int
        {
            return (_reportedCategoryId);
        }

        public function get issueAgeInMilliseconds():Number
        {
            return (_issueAgeInMilliseconds);
        }

        public function get priority():int
        {
            return (_priority);
        }

        public function get groupingId():int
        {
            return (_groupingId);
        }

        public function get reporterUserId():int
        {
            return (_reporterUserId);
        }

        public function get reporterUserName():String
        {
            return (_reporterUserName);
        }

        public function get reportedUserId():int
        {
            return (_reportedUserId);
        }

        public function get reportedUserName():String
        {
            return (_reportedUserName);
        }

        public function get pickerUserId():int
        {
            return (_pickerUserId);
        }

        public function get pickerUserName():String
        {
            return (_pickerUserName);
        }

        public function get message():String
        {
            return (_message);
        }

        public function get chatRecordId():int
        {
            return (_chatRecordId);
        }

        public function get patterns():Array
        {
            return (_patterns);
        }

        public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            for each (var _local_1:PatternMatchData in _patterns)
            {
                _local_1.dispose();
            };
            _patterns = [];
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function getOpenTime(_arg_1:int):String
        {
            var _local_7:int = int((((_issueAgeInMilliseconds + _arg_1) - _SafeStr_2068) / 1000));
            var _local_5:int = int((_local_7 / 60));
            var _local_6:int = (_local_5 % 60);
            var _local_4:int = int((_local_5 / 60));
            var _local_2:String = (((_local_6 < 10) ? "0" : "") + _local_6);
            var _local_3:String = (((_local_4 < 10) ? "0" : "") + _local_4);
            return ((_local_3 + ":") + _local_2);
        }


    }
}

