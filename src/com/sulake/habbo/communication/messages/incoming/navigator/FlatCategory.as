package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class FlatCategory 
    {

        private var _nodeId:int;
        private var _nodeName:String;
        private var _visible:Boolean;
        private var _automatic:Boolean;
        private var _automaticCategoryKey:String;
        private var _globalCategoryKey:String;
        private var _staffOnly:Boolean;

        public function FlatCategory(_arg_1:IMessageDataWrapper)
        {
            _nodeId = _arg_1.readInteger();
            _nodeName = _arg_1.readString();
            _visible = _arg_1.readBoolean();
            _automatic = _arg_1.readBoolean();
            _automaticCategoryKey = _arg_1.readString();
            _globalCategoryKey = _arg_1.readString();
            _staffOnly = _arg_1.readBoolean();
        }

        public function get nodeId():int
        {
            return (_nodeId);
        }

        public function get nodeName():String
        {
            return (_nodeName);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get automatic():Boolean
        {
            return (_automatic);
        }

        public function get staffOnly():Boolean
        {
            return (_staffOnly);
        }

        public function get automaticCategoryKey():String
        {
            return (_automaticCategoryKey);
        }

        public function get globalCategoryKey():String
        {
            return (_globalCategoryKey);
        }

        public function get visibleName():String
        {
            return ((_globalCategoryKey == "") ? _nodeName : (("${navigator.flatcategory.global." + _globalCategoryKey) + "}"));
        }


    }
}