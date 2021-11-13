package com.sulake.habbo.friendbar.groupforums
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;

    public class ThreadsListData 
    {

        public static const PAGE_SIZE:int = 20;

        private var _totalThreads:int;
        private var _startIndex:int;
        private var _threads:Array;
        private var _threadsById:Dictionary;

        public function ThreadsListData(_arg_1:int, _arg_2:int, _arg_3:Array)
        {
            super();
            var _local_4:int;
            var _local_5:* = null;
            _totalThreads = _arg_1;
            _startIndex = _arg_2;
            _threads = _arg_3;
            _threadsById = new Dictionary();
            _local_4 = 0;
            while (_local_4 < _arg_3.length)
            {
                _local_5 = _arg_3[_local_4];
                _threadsById[_local_5.threadId] = _local_5;
                _local_4++;
            };
        }

        public function get totalThreads():int
        {
            return (_totalThreads);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get threads():Array
        {
            return (_threads);
        }

        public function get threadsById():Dictionary
        {
            return (_threadsById);
        }

        public function get size():int
        {
            return (_threads.length);
        }

        public function updateThread(_arg_1:ThreadData):Boolean
        {
            var _local_3:int;
            var _local_2:ThreadData;
            threadsById[_arg_1.threadId] = _arg_1;
            _local_3 = 0;
            while (_local_3 < threads.length)
            {
                _local_2 = threads[_local_3];
                if (_local_2.threadId == _arg_1.threadId)
                {
                    threads[_local_3] = _arg_1;
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }


    }
}