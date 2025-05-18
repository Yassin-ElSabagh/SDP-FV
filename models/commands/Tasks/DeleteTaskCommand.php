<?php
require_once __DIR__ . '/../Command.php';

class DeleteTaskCommand implements Command {
    private $model;
    private $taskId;
    private $userId;
    private $oldData;

    public function __construct(TaskModel $model, $userId, $taskId) {
        $this->model = $model;
        $this->userId = $userId;
        $this->taskId = $taskId;
    }

    public function execute() {
        $this->oldData = $this->model->getTask($this->taskId);
        $this->model->deleteTask($this->taskId);
        $this->model->saveAction($this->userId, 'delete', $this->taskId, $this->oldData);
    }

    public function undo() {
        $action = $this->model->getLastAction($this->userId);
        if ($action) {
        $taskData = json_decode($action['entity_data'], true);
        $this->model->restoreTask($taskData);
        }
    }
}
?>
