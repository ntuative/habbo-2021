package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class IssueInfoMessageParser implements IMessageParser 
    {

        private var _issueData:IssueMessageData;


        public function get issueData():IssueMessageData
        {
            return (_issueData);
        }

        public function flush():Boolean
        {
            if (_issueData)
            {
            };
            _issueData = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_7:int;
            var _local_3:int = _arg_1.readInteger();
            var _local_16:int = _arg_1.readInteger();
            var _local_19:int = _arg_1.readInteger();
            var _local_17:int = _arg_1.readInteger();
            var _local_4:Number = _arg_1.readInteger();
            var _local_8:int = _arg_1.readInteger();
            var _local_5:int = _arg_1.readInteger();
            var _local_18:int = _arg_1.readInteger();
            var _local_14:String = _arg_1.readString();
            var _local_15:int = _arg_1.readInteger();
            var _local_11:String = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_13:String = _arg_1.readString();
            var _local_9:String = _arg_1.readString();
            var _local_10:int = _arg_1.readInteger();
            var _local_12:int = _arg_1.readInteger();
            var _local_6:Array = [];
            _local_7 = 0;
            while (_local_7 < _local_12)
            {
                _local_6.push(new PatternMatchData(_arg_1));
                _local_7++;
            };
            _issueData = new IssueMessageData(_local_3, _local_16, _local_19, _local_17, _local_4, _local_8, _local_5, _local_18, _local_14, _local_15, _local_11, _local_2, _local_13, _local_9, _local_10, _local_6);
            return (true);
        }


    }
}