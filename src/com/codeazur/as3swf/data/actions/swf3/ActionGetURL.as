package com.codeazur.as3swf.data.actions.swf3
{
    import com.codeazur.as3swf.data.actions.Action;
    import com.codeazur.as3swf.data.actions.IAction;
    import com.codeazur.as3swf.SWFData;

    public class ActionGetURL extends Action implements IAction 
    {

        public static const CODE:uint = 131;

        public var urlString:String;
        public var targetString:String;

        public function ActionGetURL(_arg_1:uint, _arg_2:uint)
        {
            super(_arg_1, _arg_2);
        }

        override public function parse(_arg_1:SWFData):void
        {
            urlString = _arg_1.readString();
            targetString = _arg_1.readString();
        }

        override public function publish(_arg_1:SWFData):void
        {
            var _local_2:SWFData = new SWFData();
            _local_2.writeString(urlString);
            _local_2.writeString(targetString);
            write(_arg_1, _local_2);
        }

        override public function clone():IAction
        {
            var _local_1:ActionGetURL = new ActionGetURL(code, length);
            _local_1.urlString = urlString;
            _local_1.targetString = targetString;
            return (_local_1);
        }

        override public function toString(_arg_1:uint=0):String
        {
            return ((("[ActionGetURL] URL: " + urlString) + ", Target: ") + targetString);
        }


    }
}