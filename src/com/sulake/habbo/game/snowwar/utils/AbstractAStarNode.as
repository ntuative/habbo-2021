package com.sulake.habbo.game.snowwar.utils
{
    import com.sulake.habbo.game.snowwar.arena.IGameObject;

    public class AbstractAStarNode implements IAStarNode 
    {

        private var _referenceNumber:int = -1;
        private var _nodeDirection:Direction8;
        private var _parentNode:IAStarNode;
        private var _nodeCostToGoal:int;
        private var _nodeCostFromStart:int;
        private var _disposed:Boolean = false;


        public function dispose():void
        {
            _nodeDirection = null;
            _parentNode = null;
            _nodeCostToGoal = 0;
            _nodeCostFromStart = 0;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get nodeDirection():Direction8
        {
            return (_nodeDirection);
        }

        public function set nodeDirection(_arg_1:Direction8):void
        {
            _nodeDirection = _arg_1;
        }

        public function get parentNode():IAStarNode
        {
            return (_parentNode);
        }

        public function set parentNode(_arg_1:IAStarNode):void
        {
            this._parentNode = _arg_1;
        }

        public function get nodeCostToGoal():int
        {
            return (_nodeCostToGoal);
        }

        public function set nodeCostToGoal(_arg_1:int):void
        {
            this._nodeCostToGoal = _arg_1;
        }

        public function get nodeCostFromStart():int
        {
            return (_nodeCostFromStart);
        }

        public function set nodeCostFromStart(_arg_1:int):void
        {
            this._nodeCostFromStart = _arg_1;
        }

        public function compareTo(_arg_1:AbstractAStarNode):int
        {
            var _local_3:int = (_nodeCostFromStart + _nodeCostToGoal);
            var _local_2:int = (_arg_1._nodeCostFromStart + _arg_1._nodeCostToGoal);
            if (_local_3 < _local_2)
            {
                return (-1);
            };
            if (_local_3 > _local_2)
            {
                return (1);
            };
            return (0);
        }

        public function distanceTo(_arg_1:IAStarNode):int
        {
            return (0);
        }

        public function directionTo(_arg_1:IAStarNode):Direction8
        {
            return (null);
        }

        public function getNodeAt(_arg_1:Direction8):IAStarNode
        {
            return (null);
        }

        public function directionIsBlocked(_arg_1:Direction8, _arg_2:IGameObject):Boolean
        {
            return (false);
        }

        public function getPathCost(_arg_1:Direction8, _arg_2:IGameObject):int
        {
            return (0);
        }


    }
}