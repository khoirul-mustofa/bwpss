<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD Wakaf</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<body>
    <div class="container mt-5">
        <h1>Daftar Wakaf</h1>

        @if (session('success'))
            <div class="alert alert-success">
                {{ session('success') }}
            </div>
        @endif

        <!-- Tabel Daftar Wakaf -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nama Lengkap</th>
                    <th>Sapaan</th>
                    <th>Kategori Wakaf</th>
                    <th>Harga</th>
                    <th>No WA</th>
                    <th>Email</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($wakaf as $item)
                    <tr>
                        <td>{{ $item->id }}</td>
                        <td>{{ $item->nama_lengkap }}</td>
                        <td>{{ $item->sapaan }}</td>
                        <td>{{ $item->category_wakaf }}</td>
                        <td>{{ $item->price }}</td>
                        <td>{{ $item->no_wa }}</td>
                        <td>{{ $item->email }}</td>
                        <td>
                            <!-- Form untuk mengedit wakaf -->
                            <button class="btn btn-info" data-toggle="modal"
                                data-target="#editModal{{ $item->id }}">Edit</button>

                            <!-- Modal Edit -->
                            <div class="modal fade" id="editModal{{ $item->id }}" tabindex="-1" role="dialog"
                                aria-labelledby="editModalLabel{{ $item->id }}" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editModalLabel{{ $item->id }}">Edit Wakaf
                                            </h5>
                                            <button type="button" class="close" data-dismiss="modal"
                                                aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="{{ url('/wakaf/' . $item->id) }}" method="POST">
                                                @csrf
                                                @method('PUT')

                                                <div class="form-group">
                                                    <label for="nama_lengkap">Nama Lengkap:</label>
                                                    <input type="text" class="form-control" name="nama_lengkap"
                                                        value="{{ $item->nama_lengkap }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="sapaan">Sapaan:</label>
                                                    <input type="text" class="form-control" name="sapaan"
                                                        value="{{ $item->sapaan }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="category_wakaf">Kategori Wakaf:</label>
                                                    <input type="text" class="form-control" name="category_wakaf"
                                                        value="{{ $item->category_wakaf }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="price">Harga:</label>
                                                    <input type="number" class="form-control" name="price"
                                                        value="{{ $item->price }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="no_wa">Nomor WA:</label>
                                                    <input type="text" class="form-control" name="no_wa"
                                                        value="{{ $item->no_wa }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="email">Email:</label>
                                                    <input type="email" class="form-control" name="email"
                                                        value="{{ $item->email }}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="pesan">Pesan:</label>
                                                    <textarea class="form-control" name="pesan">{{ $item->pesan }}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label for="metode_bayar">Metode Bayar:</label>
                                                    <input type="text" class="form-control" name="metode_bayar"
                                                        value="{{ $item->metode_bayar }}" required>
                                                </div>

                                                <button type="submit" class="btn btn-warning">Update</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Form untuk menghapus wakaf -->
                            <form action="{{ url('/wakaf/' . $item->id) }}" method="POST" style="display:inline;">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Apakah Anda yakin ingin menghapus wakaf ini?');">Delete</button>
                            </form>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
