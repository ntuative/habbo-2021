package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum._SafeStr_132;
    import flash.utils.Dictionary;

    public class _SafeStr_196 extends _SafeStr_132 
    {


        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            _arg_1["null"] = 0;
            _arg_1["bound_to_parent_rect"] = 32;
            _arg_1["child_window"] = 33;
            _arg_1["embedded_controller"] = 51;
            _arg_1["expand_to_accommodate_children"] = 0x20000;
            _arg_1["input_event_processor"] = 1;
            _arg_1["internal_event_handling"] = 9;
            _arg_1["mouse_dragging_target"] = 0x8000;
            _arg_1["mouse_dragging_trigger"] = 0x0101;
            _arg_1["mouse_scaling_target"] = 0x10000;
            _arg_1["mouse_scaling_trigger"] = 0x3000;
            _arg_1["horizontal_mouse_scaling_trigger"] = 0x1000;
            _arg_1["vertical_mouse_scaling_trigger"] = 0x2000;
            _arg_1["observe_parent_input_events"] = 5;
            _arg_1["parent_window"] = 1;
            _arg_1["resize_to_accommodate_children"] = 147456;
            _arg_1["relative_horizontal_scale_center"] = 192;
            _arg_1["relative_horizontal_scale_fixed"] = 0;
            _arg_1["relative_horizontal_scale_move"] = 64;
            _arg_1["relative_horizontal_scale_strech"] = 128;
            _arg_1["relative_scale_center"] = 3264;
            _arg_1["relative_scale_fixed"] = 0;
            _arg_1["relative_scale_move"] = 1088;
            _arg_1["relative_scale_strech"] = 2176;
            _arg_1["relative_vertical_scale_center"] = 0x0C00;
            _arg_1["relative_vertical_scale_fixed"] = 0;
            _arg_1["relative_vertical_scale_move"] = 0x0400;
            _arg_1["relative_vertical_scale_strech"] = 0x0800;
            _arg_1["on_resize_align_left"] = 0;
            _arg_1["on_resize_align_right"] = 0x40000;
            _arg_1["on_resize_align_center"] = 0xC0000;
            _arg_1["on_resize_align_top"] = 0;
            _arg_1["on_resize_align_bottom"] = 0x100000;
            _arg_1["on_resize_align_middle"] = 0x300000;
            _arg_1["on_accommodate_align_left"] = 0;
            _arg_1["on_accommodate_align_right"] = 0x40000;
            _arg_1["on_accommodate_align_center"] = 0xC0000;
            _arg_1["on_accommodate_align_top"] = 0;
            _arg_1["on_accommodate_align_bottom"] = 0x100000;
            _arg_1["on_accommodate_align_middle"] = 0x300000;
            _arg_1["route_input_events_to_parent"] = 3;
            _arg_1["use_parent_graphic_context"] = 16;
            _arg_1["draggable_with_mouse"] = 33025;
            _arg_1["scalable_with_mouse"] = 77824;
            _arg_1["reflect_horizontal_resize_to_parent"] = 0x400000;
            _arg_1["reflect_vertical_resize_to_parent"] = 0x800000;
            _arg_1["reflect_resize_to_parent"] = 0xC00000;
            _arg_1["force_clipping"] = 0x40000000;
            _arg_1["inherit_caption"] = 0x80000000;
            if (_arg_2 != null)
            {
                for (var _local_3:String in _arg_1)
                {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }


    }
}

