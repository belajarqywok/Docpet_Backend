"""update doctor table-day

Revision ID: 0a70cc3cba48
Revises: 400b78fadc2c
Create Date: 2023-12-07 23:07:19.551249

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '0a70cc3cba48'
down_revision = '400b78fadc2c'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('doctors', sa.Column('day', sa.String(), nullable=True))
    op.drop_column('doctors', 'date')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('doctors', sa.Column('date', sa.VARCHAR(), autoincrement=False, nullable=False))
    op.drop_column('doctors', 'day')
    # ### end Alembic commands ###