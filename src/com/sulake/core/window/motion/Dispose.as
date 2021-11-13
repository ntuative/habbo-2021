package com.sulake.core.window.motion
{
    import com.sulake.core.window.IWindow;

    use namespace friend;

    public class Dispose extends Motion 
    {

        public function Dispose(_arg_1:IWindow)
        {
            super(_arg_1);
        }

        override friend function tick(_arg_1:int):void
        {
            super.friend::tick(_arg_1);
            if (((target) && (!(target.disposed))))
            {
                target.dispose();
                target = null;
            };
        }


    }
}