package com.sulake.core.window.utils.tablet
{
    import com.sulake.core.window.utils.GenericEventQueue;
    import flash.geom.Point;
    import flash.events.IEventDispatcher;

    public class TabletEventQueue extends GenericEventQueue 
    {

        protected var _touchPosition:Point;

        public function TabletEventQueue(_arg_1:IEventDispatcher)
        {
            super(_arg_1);
            _touchPosition = new Point();
        }

        public function get touchPosition():Point
        {
            return (_touchPosition);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                super.dispose();
            };
        }


    }
}