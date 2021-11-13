package com.sulake.core.runtime
{
    public class ComponentDependency 
    {

        private var _identifier:IID;
        private var _dependencySetter:Function;
        private var _isRequired:Boolean;
        private var _eventListeners:Array;

        public function ComponentDependency(_arg_1:IID, _arg_2:Function, _arg_3:Boolean=true, _arg_4:Array=null)
        {
            _identifier = _arg_1;
            _dependencySetter = _arg_2;
            _isRequired = _arg_3;
            _eventListeners = _arg_4;
        }

        internal function get identifier():IID
        {
            return (_identifier);
        }

        internal function get dependencySetter():Function
        {
            return (_dependencySetter);
        }

        internal function get isRequired():Boolean
        {
            return (_isRequired);
        }

        internal function get eventListeners():Array
        {
            return (_eventListeners);
        }


    }
}