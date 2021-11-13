package com.sulake.habbo.freeflowchat.viewer.simulation
{
    public class ChatBubbleCollisionEvent 
    {

        private var _first:ChatBubbleSimulationEntity;
        private var _second:ChatBubbleSimulationEntity;

        public function ChatBubbleCollisionEvent(_arg_1:ChatBubbleSimulationEntity, _arg_2:ChatBubbleSimulationEntity)
        {
            _first = _arg_1;
            _second = _arg_2;
        }

        public function get first():ChatBubbleSimulationEntity
        {
            return (_first);
        }

        public function get second():ChatBubbleSimulationEntity
        {
            return (_second);
        }

        public function get top():ChatBubbleSimulationEntity
        {
            return ((_first.y < _second.y) ? _first : _second);
        }

        public function get bottom():ChatBubbleSimulationEntity
        {
            return ((_first.y >= _second.y) ? _first : _second);
        }

        public function get left():ChatBubbleSimulationEntity
        {
            return ((_first.x < _second.x) ? _first : _second);
        }

        public function get right():ChatBubbleSimulationEntity
        {
            return ((_first.x >= _second.x) ? _first : _second);
        }

        public function get areSameY():Boolean
        {
            return (_first.y == _second.y);
        }

        public function get older():ChatBubbleSimulationEntity
        {
            return ((_first.timeStamp < _second.timeStamp) ? _first : _second);
        }


    }
}