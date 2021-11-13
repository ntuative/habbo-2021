package com.sulake.room.renderer
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;

        public class RoomRendererFactory extends Component implements IRoomRendererFactory 
    {

        public function RoomRendererFactory(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
        }

        public function createRenderer():IRoomRenderer
        {
            return (new RoomRenderer(this));
        }


    }
}