package com.sulake.habbo.communication.messages.parser.camera
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CameraStorageUrlMessageParser implements IMessageParser 
    {

        private var _url:String;


        public function get url():String
        {
            return (_url);
        }

        public function flush():Boolean
        {
            _url = "";
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _url = _arg_1.readString();
            return (true);
        }


    }
}