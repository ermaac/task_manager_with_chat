class InvitedUserPermission < ApplicationRecord
  PERMITTABLE_FIELDS = %i(create_message create_note edit_note
                          delete_note move_note_to_other_list create_list edit_list_name
                          delete_list freeze_list)
  FIELD_NAMES = ['Create message', 'Create note', 'Edit note',
                 'Delete note', 'Move note to other list', 'Create list',
                 'Edit list name', 'Delete list', 'Freeze list']
  belongs_to :board
  belongs_to :user
end
