require 'rails_helper'

describe Admin::MoviesController do
  describe 'POST #create' do
    context 'when user is an admin' do
      context 'when record is valid' do
        it 'creates record' do
          admin = User.create(email: 'foo@rspec.com', password: '123123', admin: true)
          params = { movie: { title: 'rspec' } }

          sign_in(admin)
          expect { post :create, params: params }.to change { Movie.count }.by(1)
        end
      end

      context 'when record is invalid' do
        it 'does not create record' do
          admin = User.create(email: 'foo@rspec.com', password: '123123', admin: true)
          params = { movie: { title: '' } }

          sign_in(admin)
          expect { post :create, params: params }.to change { Movie.count }.by(0)
        end
      end
    end

    context 'when user is not an admin' do
      it 'redirects to login page' do
        user = User.create(email: 'foo@rspec.com', password: '123123', admin: false)
        params = { movie: { title: '' } }

        sign_in(user)
        post :create, params: params

        expect { post :create, params: params }.to change { Movie.count }.by(0)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is an admin' do
      context 'when record is valid' do
        it 'updates record' do
          admin = User.create(email: 'foo@rspec.com', password: '123123', admin: true)
          record = Movie.create(title: 'rspec')
          params = { id: record.id, movie: { title: 'rails' } }

          sign_in(admin)
          patch :update, params: params

          expect(record.reload.title).to eq 'rails'
        end
      end

      context 'when record is invalid' do
        it 'does not update record' do
          admin = User.create(email: 'foo@rspec.com', password: '123123', admin: true)
          record = Movie.create(title: 'rspec')
          params = { id: record.id, movie: { title: '' } }

          sign_in(admin)
          patch :update, params: params

          expect(record.reload.title).to eq 'rspec'
        end
      end
    end

    context 'when user is not an admin' do
      it 'redirects to login page' do
        user = User.create(email: 'foo@rspec.com', password: '123123', admin: false)
        record = Movie.create(title: 'rspec')
        params = { id: record.id, movie: { title: 'rspec' } }

        sign_in(user)
        patch :update, params: params

        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is an admin' do
      it 'deletes record' do
        admin = User.create(email: 'foo@rspec.com', password: '123123', admin: true)
        record = Movie.create(title: 'rspec')

        sign_in(admin)
        expect { delete :destroy, params: { id: record.id } }.to change { Movie.count }.by(-1)
      end

      context 'when user is not an admin' do
        it 'redirects to login page' do
          user = User.create(email: 'foo@rspec.com', password: '123123', admin: false)
          record = Movie.create(title: 'rspec')

          sign_in(user)
          delete :destroy, params: { id: record.id }

          expect(response).to redirect_to root_path
        end
      end
    end
  end
end
